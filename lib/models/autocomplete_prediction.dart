class AutocompletePrediction {
  final String description;
  final String placeId;

  AutocompletePrediction({required this.description, required this.placeId});

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    var placePrediction = json['placePrediction'];
    return AutocompletePrediction(
      description: placePrediction['text']['text'] as String,
      placeId: placePrediction['placeId'] as String,
    );
  }
}


class AutocompleteResponse {
  final List<AutocompletePrediction> predictions;

  AutocompleteResponse({required this.predictions});

  factory AutocompleteResponse.fromJson(Map<String, dynamic> json) {
    var suggestionsJson = json['suggestions'] as List;
    List<AutocompletePrediction> predictionsList = suggestionsJson
        .map(
            (suggestionJson) => AutocompletePrediction.fromJson(suggestionJson))
        .toList();
    return AutocompleteResponse(predictions: predictionsList);
  }
}




class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json['long_name'] ?? '',
      shortName: json['short_name'] ?? '',
      types: List<String>.from(json['types'] ?? []),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}



class Photo {
  final String name;
  final int height;
  final int width;
  final List<AuthorAttribution>? authorAttributions;

  Photo({
    required this.name,
    required this.height,
    required this.width,
    this.authorAttributions,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      name: json['name'],
      height: json['heightPx'],
      width: json['widthPx'],
      authorAttributions: json['authorAttributions'] != null
          ? (json['authorAttributions'] as List)
              .map((e) => AuthorAttribution.fromJson(e))
              .toList()
          : null,
    );
  }

  // to string method
  @override
  String toString() {
    return 'Photo{name: $name, height: $height, width: $width, authorAttributions: $authorAttributions}';
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

  // to string method
  @override
  String toString() {
    return 'AuthorAttribution{displayName: $displayName, uri: $uri, photoUri: $photoUri}';
  }

}

class PlaceDetailsResult {
  final String id;
  final String? formattedAddress;
  final Location? location;
  final List<AddressComponent>? addressComponents;
  final List<String>? types;
  final List<Photo>? photos;

  PlaceDetailsResult({
    required this.id,
    this.formattedAddress,
    this.location,
    this.addressComponents,
    this.types,
    this.photos,
  });

  factory PlaceDetailsResult.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsResult(
      id: json['id'] ?? '',
      formattedAddress: json['formattedAddress'] as String?,
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      addressComponents: json['address_components'] != null
          ? (json['address_components'] as List)
              .map((e) => AddressComponent.fromJson(e))
              .toList()
          : null,
      types: json['types'] != null ? List<String>.from(json['types']) : null,
      photos: json['photos'] != null
          ? (json['photos'] as List).map((e) => Photo.fromJson(e)).toList()
          : null,
    );
  }

  // to string method
  @override
  String toString() {
    return 'PlaceDetailsResult{id: $id, formattedAddress: $formattedAddress, location: $location, addressComponents: $addressComponents, types: $types, photos: $photos}';
  }
}

class PlaceDetailsResponse {
  final PlaceDetailsResult result;

  PlaceDetailsResponse({required this.result});

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsResponse(
      result: PlaceDetailsResult.fromJson(json['result'] ?? {}),
    );
  }

  // to string method
  @override
  String toString() {
    return 'PlaceDetailsResponse{result: $result}';
  }
  
}
