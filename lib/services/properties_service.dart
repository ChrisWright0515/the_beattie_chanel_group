// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/listing.dart';
// import '../models/property.dart';
// import 'api_service.dart';
// import 'google_places_service.dart';

// class PropertyService {
//   final ApiService _apiService =
//       ApiService(baseUrl: 'https://api.rentcast.io/v1/');
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final GooglePlacesService _placesService = GooglePlacesService(
//       apiService: ApiService(baseUrl: 'https://places.googleapis.com/v1/'));

//   Future<bool> addressExists(String address) async {
//     try {
//       final querySnapshot = await _firestore
//           .collection('properties')
//           .where('addressLine1', isEqualTo: address)
//           .limit(1)
//           .get();

//       return querySnapshot.docs.isNotEmpty;
//     } catch (e) {
//       print('Error checking address existence: $e');
//       return false;
//     }
//   }

//   Future<void> addProperty(Property property) async {
//     try {
//       final exists = await addressExists(property.addressLine1);
//       if (!exists) {
//         final docRef =
//             _firestore.collection('properties').doc(property.propertyId);
//         await docRef.set(property.toFirestore());
//         print('Property added: ${property.propertyId}');
//       } else {
//         print('Property already exists: ${property.addressLine1}');
//       }
//     } catch (e) {
//       print('Error adding property: $e');
//     }
//   }

//   Future<Property?> getProperty(String propertyId) async {
//     try {
//       final docSnapshot =
//           await _firestore.collection('properties').doc(propertyId).get();
//       if (docSnapshot.exists) {
//         return Property.fromFirestore(docSnapshot);
//       }
//       return null;
//     } catch (e) {
//       print('Error getting property: $e');
//       return null;
//     }
//   }

//   Future<List<Property>> getProperties() async {
//     try {
//       final response = await _apiService.getRequest('properties', headers: {
//         'Content-Type': 'application/json',
//         'x-api-key': '37853712d80f4283bf4f05f6c69d3bf8'
//       });
//       final jsonResponse = json.decode(response.body);
//       print('Properties response: $jsonResponse');
//       return (jsonResponse as List)
//           .map<Property>((json) => Property.fromJson(json))
//           .toList();
//     } catch (e) {
//       print('Error getting properties: $e');
//       return [];
//     }
//   }

//   Future<void> fetchAndAddProperties(Map<String, String> params) async {
//     try {
//       final response = await _apiService.getRequest('properties',
//           headers: {
//             'Content-Type': 'application/json',
//             'x-api-key': '37853712d80f4283bf4f05f6c69d3bf8'
//           },
//           params: params);
//       final jsonResponse = json.decode(response.body);

//       if (jsonResponse is List) {
//         for (var propertyJson in jsonResponse) {
//           try {
//             // print('Processing property: $propertyJson');
//             Property property = Property.fromJson(propertyJson);
//             await addProperty(property);
//             // print('Property added: ${property.propertyId}');
//           } catch (e) {
//             print('Error processing property: $propertyJson');
//             print('Error: $e');
//           }
//         }
//       } else {
//         print('Unexpected response format: $jsonResponse');
//       }
//     } catch (e) {
//       print('Error fetching and adding properties: $e');
//     }
//   }

//   Future<void> updateListingsWithPhotos() async {
//     try {
//       final querySnapshot = await _firestore.collection('properties').get();

//       for (var doc in querySnapshot.docs) {
//         Listing listing = Listing.fromFirestore(doc);

//         // Search for the address using Google Places API
//         final suggestions = await _placesService
//             .getAutocompleteSuggestions(listing.formattedAddress);

//         if (suggestions.predictions.isNotEmpty) {
//           final placeId = suggestions.predictions.first.placeId;

//           // Get place details
//           final placeDetails =
//               await _placesService.getPlaceDetails(placeId, fields: ['*']);

//           print('Place details: ${placeDetails.toString()}');

//           // Extract photo references
//           if (placeDetails.photos != null && placeDetails.photos!.isNotEmpty) {
//             // final photoUrls =
//             //     await Future.wait(placeDetails.photos!.map((photo) async {
//             //   return await _placesService.getPlacePhoto(
//             //     photo.name,
//             //     maxHeightPx: 400,
//             //     maxWidthPx: 400,
//             //   );
//             // }).toList());

//             // Update Firestore document with photos
//             // await _firestore
//             //     .collection('properties')
//             //     .doc(listing.listingId)
//             //     .update({'images': photoUrls});
//             print('Updated listing with ID: ${listing.listingId}');
//           } else {
//             print('No photos found for address: ${listing.formattedAddress}');
//           }
//         } else {
//           print(
//               'No suggestions found for address: ${listing.formattedAddress}');
//         }
//       }
//     } catch (e) {
//       print('Error updating listings with photos: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing.dart';
import '../models/property.dart';
import 'api_service.dart';
import 'google_places_service.dart';

class PropertyService {
  final ApiService _apiService =
      ApiService(baseUrl: 'https://api.rentcast.io/v1/');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GooglePlacesService _placesService = GooglePlacesService(
      apiService: ApiService(baseUrl: 'https://places.googleapis.com/v1/'));

  Future<bool> addressExists(String address) async {
    try {
      final querySnapshot = await _firestore
          .collection('properties')
          .where('addressLine1', isEqualTo: address)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking address existence: $e');
      return false;
    }
  }

  Future<void> addProperty(Property property) async {
    try {
      final exists = await addressExists(property.addressLine1);
      if (!exists) {
        final docRef =
            _firestore.collection('properties').doc(property.propertyId);
        await docRef.set(property.toFirestore());
      } else {
        print('Property already exists: ${property.addressLine1}');
      }
    } catch (e) {
      print('Error adding property: $e');
    }
  }

  Future<Property?> getProperty(String propertyId) async {
    try {
      final docSnapshot =
          await _firestore.collection('properties').doc(propertyId).get();
      if (docSnapshot.exists) {
        return Property.fromFirestore(docSnapshot);
      }
      return null;
    } catch (e) {
      print('Error getting property: $e');
      return null;
    }
  }

  Future<List<Property>> getProperties() async {
    try {
      final response = await _apiService.getRequest('properties', headers: {
        'Content-Type': 'application/json',
        'x-api-key': '37853712d80f4283bf4f05f6c69d3bf8'
      });
      final jsonResponse = json.decode(response.body);
      return (jsonResponse as List)
          .map<Property>((json) => Property.fromJson(json))
          .toList();
    } catch (e) {
      print('Error getting properties: $e');
      return [];
    }
  }

  Future<void> fetchAndAddProperties(Map<String, String> params) async {
    try {
      final response = await _apiService.getRequest('properties',
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': '37853712d80f4283bf4f05f6c69d3bf8'
          },
          params: params);
      final jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        for (var propertyJson in jsonResponse) {
          try {
            Property property = Property.fromJson(propertyJson);
            await addProperty(property);
          } catch (e) {
            print('Error processing property: $propertyJson');
            print('Error: $e');
          }
        }
      } else {
        print('Unexpected response format: $jsonResponse');
      }
    } catch (e) {
      print('Error fetching and adding properties: $e');
    }
  }

  Future<void> updateListingsWithPhotos() async {
    try {
      final querySnapshot = await _firestore.collection('listings').get();

      for (var doc in querySnapshot.docs) {
        Listing property = Listing.fromFirestore(doc);

        // Perform text search using Google Places API
        final searchResponse = await _placesService.textSearch(
          textQuery: property.formattedAddress,
          fields: ['places.photos', 'places.location'],
        );

        if (searchResponse.places.isNotEmpty) {
          final place = searchResponse.places.first;
          print('Place: ${place.toString()}');

          List<String> photoUrls = [];

          // Extract photo references
          if (place.photos != null && place.photos!.isNotEmpty) {
            photoUrls = await Future.wait(
              place.photos!.map((photo) async {
                if (photo.name != null && photo.name!.isNotEmpty) {
                  return await _placesService.getPlacePhoto(
                    photo.name!,
                    maxHeight: 400,
                    maxWidth: 400,
                  );
                } else {
                  return '';
                }
              }).toList(),
            );

            // Remove empty photo URLs
            photoUrls = photoUrls.where((url) => url.isNotEmpty).toList();
          }

          // Use Street View image as fallback if no photos found
          if (photoUrls.isEmpty && place.location != null) {
            final streetViewImageUrl = await _placesService.getStreetViewImage(
              place.location!.latitude,
              place.location!.longitude,
              width: 600,
              height: 400,
            );
            if (streetViewImageUrl.isNotEmpty) {
              photoUrls.add(streetViewImageUrl);
            }
          }

          // Update Firestore document with photo URLs
          if (photoUrls.isNotEmpty) {
            await _firestore
                .collection('listings')
                .doc(property.listingId)
                .update({'images': photoUrls});
            print('Updated property with ID: ${property.listingId}');
          } else {
            print(
                'No valid photos found for address: ${property.addressLine1}');
          }
        } else {
          print('No places found for address: ${property.addressLine1}');
        }
      }
    } catch (e) {
      print('Error updating listings with photos: $e');
    }
  }
}
