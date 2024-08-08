// import 'dart:convert';
// import '../models/autocomplete_prediction.dart';
// import 'api_service.dart';

// class GooglePlacesService {
//   final ApiService apiService;
//   final String baseUrl = 'https://places.googleapis.com/v1/';
//   final String serviceName = 'GOOGLE_MAP_API_KEY';

//   GooglePlacesService({required this.apiService});

//   Future<AutocompleteResponse> getAutocompleteSuggestions(String input,
//       {String? sessionToken}) async {
//     final body = {
//       "input": input,
//       "sessionToken": sessionToken,
//     };

//     try {
//       final headers = {
//         'Content-Type': 'application/json',
//         'X-Goog-Api-Key': await apiService.getApiKey(serviceName) ?? ''
//       };
//       print('Autocomplete request headers: $headers'); // Debugging

//       final response = await apiService.postRequest(
//         'places:autocomplete',
//         body,
//         headers: headers,
//       );

//       final jsonResponse = json.decode(response.body);
//       return AutocompleteResponse.fromJson(jsonResponse);
//     } catch (e) {
//       print('Error in getAutocompleteSuggestions: $e');
//       rethrow;
//     }
//   }

//   Future<PlaceDetailsResult> getPlaceDetails(String placeId,
//       {required List<String> fields}) async {
//     final fieldsQuery = fields.join(',');
//     final endpoint = 'places/$placeId';
//     final headers = {
//       'Content-Type': 'application/json',
//       'X-Goog-Api-Key': await apiService.getApiKey(serviceName) ?? '',
//       'X-Goog-FieldMask': fieldsQuery,
//     };
//     print('Place details request headers: $headers'); // Debugging

//     try {
//       final response = await apiService.getRequest(endpoint, headers: headers);
//       final jsonResponse = json.decode(response.body);
//       PlaceDetailsResponse placeDetailsResponse =
//           PlaceDetailsResponse.fromJson(jsonResponse);
//       print('Place details response: $jsonResponse'); // Debugging

//       return placeDetailsResponse.result;
//     } catch (e) {
//       print('Error in getPlaceDetails: $e');
//       rethrow;
//     }
//   }

//   Future<NearbySearchResponse> searchNearby({
//     required double latitude,
//     required double longitude,
//     required double radius,
//     required List<String> includedTypes,
//     required List<String> fields,
//     int maxResultCount = 10,
//   }) async {
//     final body = {
//       "locationRestriction": {
//         "circle": {
//           "center": {"latitude": latitude, "longitude": longitude},
//           "radius": 50000.0
//         }
//       },
//       "includedTypes": includedTypes,
//       "maxResultCount": maxResultCount
//     };

//     final headers = {
//       'Content-Type': 'application/json',
//       'X-Goog-Api-Key': await apiService.getApiKey(serviceName) ?? '',
//       'X-Goog-FieldMask': fields.join(',')
//     };

//     try {
//       final response = await apiService.postRequest(
//         'places:searchNearby',
//         body,
//         headers: headers,
//       );

//       final jsonResponse = json.decode(response.body);
//       return NearbySearchResponse.fromJson(jsonResponse);
//     } catch (e) {
//       print('Error in searchNearby: $e');
//       rethrow;
//     }
//   }
// }

// class NearbySearchResponse {
//   final List<Place> places;

//   NearbySearchResponse({required this.places});

//   factory NearbySearchResponse.fromJson(Map<String, dynamic> json) {
//     return NearbySearchResponse(
//       places: (json['places'] as List).map((e) => Place.fromJson(e)).toList(),
//     );
//   }
// }

// class Place {
//   final String displayName;
//   final String formattedAddress;
//   final String placeId;

//   Place(
//       {required this.displayName,
//       required this.formattedAddress,
//       required this.placeId});

//   factory Place.fromJson(Map<String, dynamic> json) {
//     return Place(
//       displayName: json['displayName']['text'],
//       formattedAddress: json['formattedAddress'],
//       placeId: json['placeId'],
//     );
//   }
// }

import 'dart:convert';
import '../models/autocomplete_prediction.dart';
import 'api_service.dart';

class GooglePlacesService {
  final ApiService apiService;
  final String baseUrl = 'https://places.googleapis.com/v1/';
  final String serviceName = 'GOOGLE_MAP_API_KEY';

  GooglePlacesService({required this.apiService});

  Future<AutocompleteResponse> getAutocompleteSuggestions(String input,
      {String? sessionToken}) async {
    final body = {
      "input": input,
      "sessionToken": sessionToken,
    };

    try {
      final headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': await apiService.getApiKey(serviceName) ?? ''
      };

      final response = await apiService.postRequest(
        'places:autocomplete',
        body,
        headers: headers,
      );

      final jsonResponse = json.decode(response.body);
      return AutocompleteResponse.fromJson(jsonResponse);
    } catch (e) {
      rethrow;
    }
  }

  Future<PlaceDetailsResult> getPlaceDetails(String placeId,
      {required List<String> fields}) async {
    final fieldsQuery = fields.join(',');
    final endpoint = 'places/$placeId';
    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': await apiService.getApiKey(serviceName) ?? '',
      'X-Goog-FieldMask': fieldsQuery,
    };

    try {
      final response = await apiService.getRequest(endpoint, headers: headers);
      final jsonResponse = json.decode(response.body);
      print('Place details response: $jsonResponse');

      PlaceDetailsResponse placeDetailsResponse =
          PlaceDetailsResponse.fromJson(jsonResponse);

      return placeDetailsResponse.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<NearbySearchResponse> searchNearby({
    required double latitude,
    required double longitude,
    required double radius,
    required List<String> includedTypes,
    required List<String> fields,
    int maxResultCount = 10,
  }) async {
    final body = {
      "locationRestriction": {
        "circle": {
          "center": {"latitude": latitude, "longitude": longitude},
          "radius": radius
        }
      },
      "includedTypes": includedTypes,
      "maxResultCount": maxResultCount
    };

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': await apiService.getApiKey(serviceName) ?? '',
      'X-Goog-FieldMask': fields.join(',')
    };

    try {
      final response = await apiService.postRequest(
        'places:searchNearby',
        body,
        headers: headers,
      );

      final jsonResponse = json.decode(response.body);
      return NearbySearchResponse.fromJson(jsonResponse);
    } catch (e) {
      rethrow;
    }
  }

  Future<TextSearchResponse> textSearch({
    required String textQuery,
    String? languageCode,
    Map<String, dynamic>? locationBias,
    Map<String, dynamic>? locationRestriction,
    bool? openNow,
    int? pageSize,
    String? pageToken,
    List<String>? fields,
  }) async {
    final body = {
      "textQuery": textQuery,
    };

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': await apiService.getApiKey(serviceName) ?? '',
      if (fields != null) 'X-Goog-FieldMask': fields.join(',')
    };

    try {
      final response = await apiService.postRequest(
        'places:searchText',
        body,
        headers: headers,
      );
      print('Text search response: ${response.body}');

      final jsonResponse = json.decode(response.body);
      print('Text search response: $jsonResponse');
      return TextSearchResponse.fromJson(jsonResponse);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getPlacePhoto(String photoReference,
      {int? maxHeight, int? maxWidth}) async {
    final endpoint = 'photo';
    final params = {
      'photoreference': photoReference,
      'key': await apiService.getApiKey(serviceName) ?? '',
      if (maxHeight != null) 'maxheight': maxHeight.toString(),
      if (maxWidth != null) 'maxwidth': maxWidth.toString(),
    };

    try {
      final uri = Uri.https(baseUrl, endpoint, params);
      final response = await apiService.getRequest(uri.toString());
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load photo');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getStreetViewImage(double latitude, double longitude,
      {int? heading, int? pitch, int? fov, int? width, int? height}) async {
    final params = {
      'location': '$latitude,$longitude',
      'key': await apiService.getApiKey(serviceName) ?? '',
      if (heading != null) 'heading': heading.toString(),
      if (pitch != null) 'pitch': pitch.toString(),
      if (fov != null) 'fov': fov.toString(),
      if (width != null) 'size': '${width}x${height}',
    };

    final uri =
        Uri.https('maps.googleapis.com', '/maps/api/streetview', params);
    return uri.toString();
  }
}

// Model for TextSearchResponse

class TextSearchResponse {
  final List<Place> places;
  final String? nextPageToken;

  TextSearchResponse({
    required this.places,
    this.nextPageToken,
  });

  factory TextSearchResponse.fromJson(Map<String, dynamic> json) {
    return TextSearchResponse(
      places: (json['places'] as List).map((e) => Place.fromJson(e)).toList(),
      nextPageToken: json['nextPageToken'],
    );
  }
}

class NearbySearchResponse {
  final List<Place> places;

  NearbySearchResponse({required this.places});

  factory NearbySearchResponse.fromJson(Map<String, dynamic> json) {
    return NearbySearchResponse(
      places: (json['places'] as List).map((e) => Place.fromJson(e)).toList(),
    );
  }
}

class Place {
  final String? name;
  final String? id;
  final LocalizedText? displayName;
  final List<String>? types;
  final String? primaryType;
  final LocalizedText? primaryTypeDisplayName;
  final String? nationalPhoneNumber;
  final String? internationalPhoneNumber;
  final String? formattedAddress;
  final String? shortFormattedAddress;
  final List<AddressComponent>? addressComponents;
  final PlusCode? plusCode;
  final LatLng? location;
  final Viewport? viewport;
  final double? rating;
  final String? googleMapsUri;
  final String? websiteUri;
  final List<Review>? reviews;
  final OpeningHours? regularOpeningHours;
  final List<Photo>? photos;
  final String? adrFormatAddress;
  final BusinessStatus? businessStatus;
  final PriceLevel? priceLevel;
  final List<Attribution>? attributions;
  final String? iconMaskBaseUri;
  final String? iconBackgroundColor;
  final OpeningHours? currentOpeningHours;
  final List<OpeningHours>? currentSecondaryOpeningHours;
  final List<OpeningHours>? regularSecondaryOpeningHours;
  final LocalizedText? editorialSummary;
  final PaymentOptions? paymentOptions;
  final ParkingOptions? parkingOptions;
  final List<SubDestination>? subDestinations;
  final FuelOptions? fuelOptions;
  final EVChargeOptions? evChargeOptions;
  final GenerativeSummary? generativeSummary;
  final AreaSummary? areaSummary;
  final int? utcOffsetMinutes;
  final int? userRatingCount;
  final bool? takeout;
  final bool? delivery;
  final bool? dineIn;
  final bool? curbsidePickup;
  final bool? reservable;
  final bool? servesBreakfast;
  final bool? servesLunch;
  final bool? servesDinner;
  final bool? servesBeer;
  final bool? servesWine;
  final bool? servesBrunch;
  final bool? servesVegetarianFood;
  final bool? outdoorSeating;
  final bool? liveMusic;
  final bool? menuForChildren;
  final bool? servesCocktails;
  final bool? servesDessert;
  final bool? servesCoffee;
  final bool? goodForChildren;
  final bool? allowsDogs;
  final bool? restroom;
  final bool? goodForGroups;
  final bool? goodForWatchingSports;
  final AccessibilityOptions? accessibilityOptions;

  Place({
    this.name,
    this.id,
    this.displayName,
    this.types,
    this.primaryType,
    this.primaryTypeDisplayName,
    this.nationalPhoneNumber,
    this.internationalPhoneNumber,
    this.formattedAddress,
    this.shortFormattedAddress,
    this.addressComponents,
    this.plusCode,
    this.location,
    this.viewport,
    this.rating,
    this.googleMapsUri,
    this.websiteUri,
    this.reviews,
    this.regularOpeningHours,
    this.photos,
    this.adrFormatAddress,
    this.businessStatus,
    this.priceLevel,
    this.attributions,
    this.iconMaskBaseUri,
    this.iconBackgroundColor,
    this.currentOpeningHours,
    this.currentSecondaryOpeningHours,
    this.regularSecondaryOpeningHours,
    this.editorialSummary,
    this.paymentOptions,
    this.parkingOptions,
    this.subDestinations,
    this.fuelOptions,
    this.evChargeOptions,
    this.generativeSummary,
    this.areaSummary,
    this.utcOffsetMinutes,
    this.userRatingCount,
    this.takeout,
    this.delivery,
    this.dineIn,
    this.curbsidePickup,
    this.reservable,
    this.servesBreakfast,
    this.servesLunch,
    this.servesDinner,
    this.servesBeer,
    this.servesWine,
    this.servesBrunch,
    this.servesVegetarianFood,
    this.outdoorSeating,
    this.liveMusic,
    this.menuForChildren,
    this.servesCocktails,
    this.servesDessert,
    this.servesCoffee,
    this.goodForChildren,
    this.allowsDogs,
    this.restroom,
    this.goodForGroups,
    this.goodForWatchingSports,
    this.accessibilityOptions,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      id: json['id'],
      displayName: json['displayName'] != null
          ? LocalizedText.fromJson(json['displayName'])
          : null,
      types: json['types'] != null ? List<String>.from(json['types']) : null,
      primaryType: json['primaryType'],
      primaryTypeDisplayName: json['primaryTypeDisplayName'] != null
          ? LocalizedText.fromJson(json['primaryTypeDisplayName'])
          : null,
      nationalPhoneNumber: json['nationalPhoneNumber'],
      internationalPhoneNumber: json['internationalPhoneNumber'],
      formattedAddress: json['formattedAddress'],
      shortFormattedAddress: json['shortFormattedAddress'],
      addressComponents: json['addressComponents'] != null
          ? (json['addressComponents'] as List)
              .map((e) => AddressComponent.fromJson(e))
              .toList()
          : null,
      plusCode:
          json['plusCode'] != null ? PlusCode.fromJson(json['plusCode']) : null,
      location:
          json['location'] != null ? LatLng.fromJson(json['location']) : null,
      viewport:
          json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null,
      rating: json['rating'] != null ? json['rating'].toDouble() : null,
      googleMapsUri: json['googleMapsUri'],
      websiteUri: json['websiteUri'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((e) => Review.fromJson(e)).toList()
          : null,
      regularOpeningHours: json['regularOpeningHours'] != null
          ? OpeningHours.fromJson(json['regularOpeningHours'])
          : null,
      photos: json['photos'] != null
          ? (json['photos'] as List).map((e) => Photo.fromJson(e)).toList()
          : null,
      adrFormatAddress: json['adrFormatAddress'],
      businessStatus: json['businessStatus'] != null
          ? BusinessStatus.values.firstWhere(
              (e) => e.toString() == 'BusinessStatus.${json['businessStatus']}')
          : null,
      priceLevel: json['priceLevel'] != null
          ? PriceLevel.values.firstWhere(
              (e) => e.toString() == 'PriceLevel.${json['priceLevel']}')
          : null,
      attributions: json['attributions'] != null
          ? (json['attributions'] as List)
              .map((e) => Attribution.fromJson(e))
              .toList()
          : null,
      iconMaskBaseUri: json['iconMaskBaseUri'],
      iconBackgroundColor: json['iconBackgroundColor'],
      currentOpeningHours: json['currentOpeningHours'] != null
          ? OpeningHours.fromJson(json['currentOpeningHours'])
          : null,
      currentSecondaryOpeningHours: json['currentSecondaryOpeningHours'] != null
          ? (json['currentSecondaryOpeningHours'] as List)
              .map((e) => OpeningHours.fromJson(e))
              .toList()
          : null,
      regularSecondaryOpeningHours: json['regularSecondaryOpeningHours'] != null
          ? (json['regularSecondaryOpeningHours'] as List)
              .map((e) => OpeningHours.fromJson(e))
              .toList()
          : null,
      editorialSummary: json['editorialSummary'] != null
          ? LocalizedText.fromJson(json['editorialSummary'])
          : null,
      paymentOptions: json['paymentOptions'] != null
          ? PaymentOptions.fromJson(json['paymentOptions'])
          : null,
      parkingOptions: json['parkingOptions'] != null
          ? ParkingOptions.fromJson(json['parkingOptions'])
          : null,
      subDestinations: json['subDestinations'] != null
          ? (json['subDestinations'] as List)
              .map((e) => SubDestination.fromJson(e))
              .toList()
          : null,
      fuelOptions: json['fuelOptions'] != null
          ? FuelOptions.fromJson(json['fuelOptions'])
          : null,
      evChargeOptions: json['evChargeOptions'] != null
          ? EVChargeOptions.fromJson(json['evChargeOptions'])
          : null,
      generativeSummary: json['generativeSummary'] != null
          ? GenerativeSummary.fromJson(json['generativeSummary'])
          : null,
      areaSummary: json['areaSummary'] != null
          ? AreaSummary.fromJson(json['areaSummary'])
          : null,
      utcOffsetMinutes: json['utcOffsetMinutes'],
      userRatingCount: json['userRatingCount'],
      takeout: json['takeout'],
      delivery: json['delivery'],
      dineIn: json['dineIn'],
      curbsidePickup: json['curbsidePickup'],
      reservable: json['reservable'],
      servesBreakfast: json['servesBreakfast'],
      servesLunch: json['servesLunch'],
      servesDinner: json['servesDinner'],
      servesBeer: json['servesBeer'],
      servesWine: json['servesWine'],
      servesBrunch: json['servesBrunch'],
      servesVegetarianFood: json['servesVegetarianFood'],
      outdoorSeating: json['outdoorSeating'],
      liveMusic: json['liveMusic'],
      menuForChildren: json['menuForChildren'],
      servesCocktails: json['servesCocktails'],
      servesDessert: json['servesDessert'],
      servesCoffee: json['servesCoffee'],
      goodForChildren: json['goodForChildren'],
      allowsDogs: json['allowsDogs'],
      restroom: json['restroom'],
      goodForGroups: json['goodForGroups'],
      goodForWatchingSports: json['goodForWatchingSports'],
      accessibilityOptions: json['accessibilityOptions'] != null
          ? AccessibilityOptions.fromJson(json['accessibilityOptions'])
          : null,
    );
  }
}

class LocalizedText {
  final String text;
  final String languageCode;

  LocalizedText({
    required this.text,
    required this.languageCode,
  });

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      text: json['text'],
      languageCode: json['languageCode'],
    );
  }
}

class AddressComponent {
  final String longText;
  final String shortText;
  final List<String> types;
  final String languageCode;

  AddressComponent({
    required this.longText,
    required this.shortText,
    required this.types,
    required this.languageCode,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longText: json['longText'],
      shortText: json['shortText'],
      types: List<String>.from(json['types']),
      languageCode: json['languageCode'],
    );
  }
}

class PlusCode {
  final String globalCode;
  final String compoundCode;

  PlusCode({
    required this.globalCode,
    required this.compoundCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      globalCode: json['globalCode'],
      compoundCode: json['compoundCode'],
    );
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Viewport {
  final LatLng low;
  final LatLng high;

  Viewport({
    required this.low,
    required this.high,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      low: LatLng.fromJson(json['low']),
      high: LatLng.fromJson(json['high']),
    );
  }
}

class Review {
  final String name;
  final String relativePublishTimeDescription;
  final LocalizedText text;
  final LocalizedText originalText;
  final double rating;
  final AuthorAttribution authorAttribution;
  final String publishTime;

  Review({
    required this.name,
    required this.relativePublishTimeDescription,
    required this.text,
    required this.originalText,
    required this.rating,
    required this.authorAttribution,
    required this.publishTime,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      name: json['name'],
      relativePublishTimeDescription: json['relativePublishTimeDescription'],
      text: LocalizedText.fromJson(json['text']),
      originalText: LocalizedText.fromJson(json['originalText']),
      rating: json['rating'].toDouble(),
      authorAttribution: AuthorAttribution.fromJson(json['authorAttribution']),
      publishTime: json['publishTime'],
    );
  }
}

class AuthorAttribution {
  final String displayName;
  final String uri;
  final String photoUri;

  AuthorAttribution({
    required this.displayName,
    required this.uri,
    required this.photoUri,
  });

  factory AuthorAttribution.fromJson(Map<String, dynamic> json) {
    return AuthorAttribution(
      displayName: json['displayName'],
      uri: json['uri'],
      photoUri: json['photoUri'],
    );
  }
}

class OpeningHours {
  final List<Period> periods;
  final List<String> weekdayDescriptions;
  final SecondaryHoursType secondaryHoursType;
  final List<SpecialDay> specialDays;
  final bool openNow;

  OpeningHours({
    required this.periods,
    required this.weekdayDescriptions,
    required this.secondaryHoursType,
    required this.specialDays,
    required this.openNow,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      periods:
          (json['periods'] as List).map((e) => Period.fromJson(e)).toList(),
      weekdayDescriptions: List<String>.from(json['weekdayDescriptions']),
      secondaryHoursType: SecondaryHoursType.values.firstWhere((e) =>
          e.toString() == 'SecondaryHoursType.${json['secondaryHoursType']}'),
      specialDays: (json['specialDays'] as List)
          .map((e) => SpecialDay.fromJson(e))
          .toList(),
      openNow: json['openNow'],
    );
  }
}

class Period {
  final Point open;
  final Point close;

  Period({
    required this.open,
    required this.close,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      open: Point.fromJson(json['open']),
      close: Point.fromJson(json['close']),
    );
  }
}

class Point {
  final Date date;
  final bool truncated;
  final int day;
  final int hour;
  final int minute;

  Point({
    required this.date,
    required this.truncated,
    required this.day,
    required this.hour,
    required this.minute,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      date: Date.fromJson(json['date']),
      truncated: json['truncated'],
      day: json['day'],
      hour: json['hour'],
      minute: json['minute'],
    );
  }
}

class Date {
  final int year;
  final int month;
  final int day;

  Date({
    required this.year,
    required this.month,
    required this.day,
  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      year: json['year'],
      month: json['month'],
      day: json['day'],
    );
  }
}

class Photo {
  final String name;
  final int widthPx;
  final int heightPx;
  final List<AuthorAttribution> authorAttributions;

  Photo({
    required this.name,
    required this.widthPx,
    required this.heightPx,
    required this.authorAttributions,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      name: json['name'],
      widthPx: json['widthPx'],
      heightPx: json['heightPx'],
      authorAttributions: (json['authorAttributions'] as List)
          .map((e) => AuthorAttribution.fromJson(e))
          .toList(),
    );
  }
}

enum BusinessStatus {
  BUSINESS_STATUS_UNSPECIFIED,
  OPERATIONAL,
  CLOSED_TEMPORARILY,
  CLOSED_PERMANENTLY
}

enum PriceLevel {
  PRICE_LEVEL_UNSPECIFIED,
  PRICE_LEVEL_FREE,
  PRICE_LEVEL_INEXPENSIVE,
  PRICE_LEVEL_MODERATE,
  PRICE_LEVEL_EXPENSIVE,
  PRICE_LEVEL_VERY_EXPENSIVE
}

class Attribution {
  final String provider;
  final String providerUri;

  Attribution({
    required this.provider,
    required this.providerUri,
  });

  factory Attribution.fromJson(Map<String, dynamic> json) {
    return Attribution(
      provider: json['provider'],
      providerUri: json['providerUri'],
    );
  }
}

class PaymentOptions {
  final bool acceptsCreditCards;
  final bool acceptsDebitCards;
  final bool acceptsCashOnly;
  final bool acceptsNfc;

  PaymentOptions({
    required this.acceptsCreditCards,
    required this.acceptsDebitCards,
    required this.acceptsCashOnly,
    required this.acceptsNfc,
  });

  factory PaymentOptions.fromJson(Map<String, dynamic> json) {
    return PaymentOptions(
      acceptsCreditCards: json['acceptsCreditCards'],
      acceptsDebitCards: json['acceptsDebitCards'],
      acceptsCashOnly: json['acceptsCashOnly'],
      acceptsNfc: json['acceptsNfc'],
    );
  }
}

class ParkingOptions {
  final bool freeParkingLot;
  final bool paidParkingLot;
  final bool freeStreetParking;
  final bool paidStreetParking;
  final bool valetParking;
  final bool freeGarageParking;
  final bool paidGarageParking;

  ParkingOptions({
    required this.freeParkingLot,
    required this.paidParkingLot,
    required this.freeStreetParking,
    required this.paidStreetParking,
    required this.valetParking,
    required this.freeGarageParking,
    required this.paidGarageParking,
  });

  factory ParkingOptions.fromJson(Map<String, dynamic> json) {
    return ParkingOptions(
      freeParkingLot: json['freeParkingLot'],
      paidParkingLot: json['paidParkingLot'],
      freeStreetParking: json['freeStreetParking'],
      paidStreetParking: json['paidStreetParking'],
      valetParking: json['valetParking'],
      freeGarageParking: json['freeGarageParking'],
      paidGarageParking: json['paidGarageParking'],
    );
  }
}

class SubDestination {
  final String name;
  final String id;

  SubDestination({
    required this.name,
    required this.id,
  });

  factory SubDestination.fromJson(Map<String, dynamic> json) {
    return SubDestination(
      name: json['name'],
      id: json['id'],
    );
  }
}

class AccessibilityOptions {
  final bool wheelchairAccessibleParking;
  final bool wheelchairAccessibleEntrance;
  final bool wheelchairAccessibleRestroom;
  final bool wheelchairAccessibleSeating;

  AccessibilityOptions({
    required this.wheelchairAccessibleParking,
    required this.wheelchairAccessibleEntrance,
    required this.wheelchairAccessibleRestroom,
    required this.wheelchairAccessibleSeating,
  });

  factory AccessibilityOptions.fromJson(Map<String, dynamic> json) {
    return AccessibilityOptions(
      wheelchairAccessibleParking: json['wheelchairAccessibleParking'],
      wheelchairAccessibleEntrance: json['wheelchairAccessibleEntrance'],
      wheelchairAccessibleRestroom: json['wheelchairAccessibleRestroom'],
      wheelchairAccessibleSeating: json['wheelchairAccessibleSeating'],
    );
  }
}

class FuelOptions {
  final List<FuelPrice> fuelPrices;

  FuelOptions({
    required this.fuelPrices,
  });

  factory FuelOptions.fromJson(Map<String, dynamic> json) {
    return FuelOptions(
      fuelPrices: (json['fuelPrices'] as List)
          .map((e) => FuelPrice.fromJson(e))
          .toList(),
    );
  }
}

class FuelPrice {
  final FuelType type;
  final Money price;
  final String updateTime;

  FuelPrice({
    required this.type,
    required this.price,
    required this.updateTime,
  });

  factory FuelPrice.fromJson(Map<String, dynamic> json) {
    return FuelPrice(
      type: FuelType.values
          .firstWhere((e) => e.toString() == 'FuelType.${json['type']}'),
      price: Money.fromJson(json['price']),
      updateTime: json['updateTime'],
    );
  }
}

enum FuelType {
  FUEL_TYPE_UNSPECIFIED,
  DIESEL,
  REGULAR_UNLEADED,
  MIDGRADE,
  PREMIUM,
  SP91,
  SP91_E10,
  SP92,
  SP95,
  SP95_E10,
  SP98,
  SP99,
  SP100,
  LPG,
  E80,
  E85,
  METHANE,
  BIO_DIESEL,
  TRUCK_DIESEL
}

class Money {
  final String currencyCode;
  final String units;
  final int nanos;

  Money({
    required this.currencyCode,
    required this.units,
    required this.nanos,
  });

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
      currencyCode: json['currencyCode'],
      units: json['units'],
      nanos: json['nanos'],
    );
  }
}

class EVChargeOptions {
  final int connectorCount;
  final List<ConnectorAggregation> connectorAggregation;

  EVChargeOptions({
    required this.connectorCount,
    required this.connectorAggregation,
  });

  factory EVChargeOptions.fromJson(Map<String, dynamic> json) {
    return EVChargeOptions(
      connectorCount: json['connectorCount'],
      connectorAggregation: (json['connectorAggregation'] as List)
          .map((e) => ConnectorAggregation.fromJson(e))
          .toList(),
    );
  }
}

class ConnectorAggregation {
  final EVConnectorType type;
  final double maxChargeRateKw;
  final int count;
  final String availabilityLastUpdateTime;
  final int availableCount;
  final int outOfServiceCount;

  ConnectorAggregation({
    required this.type,
    required this.maxChargeRateKw,
    required this.count,
    required this.availabilityLastUpdateTime,
    required this.availableCount,
    required this.outOfServiceCount,
  });

  factory ConnectorAggregation.fromJson(Map<String, dynamic> json) {
    return ConnectorAggregation(
      type: EVConnectorType.values
          .firstWhere((e) => e.toString() == 'EVConnectorType.${json['type']}'),
      maxChargeRateKw: json['maxChargeRateKw'],
      count: json['count'],
      availabilityLastUpdateTime: json['availabilityLastUpdateTime'],
      availableCount: json['availableCount'],
      outOfServiceCount: json['outOfServiceCount'],
    );
  }
}

enum EVConnectorType {
  EV_CONNECTOR_TYPE_UNSPECIFIED,
  EV_CONNECTOR_TYPE_OTHER,
  EV_CONNECTOR_TYPE_J1772,
  EV_CONNECTOR_TYPE_TYPE_2,
  EV_CONNECTOR_TYPE_CHADEMO,
  EV_CONNECTOR_TYPE_CCS_COMBO_1,
  EV_CONNECTOR_TYPE_CCS_COMBO_2,
  EV_CONNECTOR_TYPE_TESLA,
  EV_CONNECTOR_TYPE_UNSPECIFIED_GB_T,
  EV_CONNECTOR_TYPE_UNSPECIFIED_WALL_OUTLET
}

class GenerativeSummary {
  final LocalizedText overview;
  final LocalizedText description;
  final References references;

  GenerativeSummary({
    required this.overview,
    required this.description,
    required this.references,
  });

  factory GenerativeSummary.fromJson(Map<String, dynamic> json) {
    return GenerativeSummary(
      overview: LocalizedText.fromJson(json['overview']),
      description: LocalizedText.fromJson(json['description']),
      references: References.fromJson(json['references']),
    );
  }
}

class AreaSummary {
  final List<ContentBlock> contentBlocks;

  AreaSummary({
    required this.contentBlocks,
  });

  factory AreaSummary.fromJson(Map<String, dynamic> json) {
    return AreaSummary(
      contentBlocks: (json['contentBlocks'] as List)
          .map((e) => ContentBlock.fromJson(e))
          .toList(),
    );
  }
}

class ContentBlock {
  final String topic;
  final LocalizedText content;
  final References references;

  ContentBlock({
    required this.topic,
    required this.content,
    required this.references,
  });

  factory ContentBlock.fromJson(Map<String, dynamic> json) {
    return ContentBlock(
      topic: json['topic'],
      content: LocalizedText.fromJson(json['content']),
      references: References.fromJson(json['references']),
    );
  }
}

class References {
  final List<Review> reviews;
  final List<String> places;

  References({
    required this.reviews,
    required this.places,
  });

  factory References.fromJson(Map<String, dynamic> json) {
    return References(
      reviews:
          (json['reviews'] as List).map((e) => Review.fromJson(e)).toList(),
      places: List<String>.from(json['places']),
    );
  }
}

enum SecondaryHoursType {
  SECONDARY_HOURS_TYPE_UNSPECIFIED,
  DRIVE_THROUGH,
  HAPPY_HOUR,
  DELIVERY,
  TAKEOUT,
  KITCHEN,
  BREAKFAST,
  LUNCH,
  DINNER,
  BRUNCH,
  PICKUP,
  ACCESS,
  SENIOR_HOURS,
  ONLINE_SERVICE_HOURS
}

class SpecialDay {
  final Date date;

  SpecialDay({
    required this.date,
  });

  factory SpecialDay.fromJson(Map<String, dynamic> json) {
    return SpecialDay(
      date: Date.fromJson(json['date']),
    );
  }
}
