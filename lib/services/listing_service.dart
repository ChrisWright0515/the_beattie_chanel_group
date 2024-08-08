// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/listing.dart';
// import 'api_service.dart';

// class ListingService {
//   final ApiService _apiService = ApiService(baseUrl: 'https://api.rentcast.io/v1/');
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> fetchAndAddListings(Map<String, String> params) async {
//     try {
//       final response = await _apiService.getRequest('listings/sale', headers: {
//         'Content-Type': 'application/json',
//         'x-api-key': '37853712d80f4283bf4f05f6c69d3bf8'
//       }, params: params);

//       final jsonResponse = json.decode(response.body);

//       if (jsonResponse is List) {
//         for (var listingJson in jsonResponse) {
//           try {
//             print('Processing listing: $listingJson');
//             Listing listing = Listing.fromJson(listingJson);
//             await addListing(listing);
//           } catch (e) {
//             print('Error processing listing: $listingJson');
//             print('Error: $e');
//           }
//         }
//       } else {
//         print('Unexpected response format: $jsonResponse');
//       }
//     } catch (e) {
//       print('Error fetching and adding listings: $e');
//     }
//   }

//   Future<void> addListing(Listing listing) async {
//     try {
//       final docRef = _firestore.collection('listings').doc(listing.listingId);
//       await docRef.set(listing.toFirestore());
//       print('Listing added: ${listing.listingId}');
//     } catch (e) {
//       print('Error adding listing: $e');
//     }
//   }
// }


import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing.dart';
import 'api_service.dart';

class ListingService {
  final ApiService _apiService =
      ApiService(baseUrl: 'https://api.rentcast.io/v1/');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch the most recent listings for the current week
  Stream<List<Listing>> getRecentListings() {
    final oneWeekAgo = DateTime.now().subtract(Duration(days: 7));

    return _firestore
        .collection('listings')
        .where('listedDate', isGreaterThan: Timestamp.fromDate(oneWeekAgo))
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Listing.fromFirestore(doc)).toList());
  }

  // Function to fetch the listings that have an agent ID
  Stream<List<Listing>> getAgentListings() {
    return _firestore
        .collection('listings')
        .where('agentId', isNotEqualTo: null)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Listing.fromFirestore(doc)).toList());
  }
  Future<void> fetchAndAddListings(Map<String, String> params) async {
    try {
      final response = await _apiService.getRequest('listings/sale',
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': '37853712d80f4283bf4f05f6c69d3bf8'
          },
          params: params);

      final jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        for (var listingJson in jsonResponse) {
          try {
            Listing listing = Listing.fromJson(listingJson);
            await addListing(listing);
          } catch (e) {
            print('Error processing listing: $listingJson');
            print('Error: $e');
          }
        }
      } else {
        print('Unexpected response format: $jsonResponse');
      }
    } catch (e) {
      print('Error fetching and adding listings: $e');
    }
  }

  Future<void> addListing(Listing listing) async {
    try {
      final docRef = _firestore.collection('listings').doc(listing.listingId);
      await docRef.set(listing.toFirestore());
      print('Listing added: ${listing.listingId}');
    } catch (e) {
      print('Error adding listing: $e');
    }
  }


}
