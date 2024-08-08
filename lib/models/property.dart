import 'package:cloud_firestore/cloud_firestore.dart';

class Property {
  String propertyId;
  String formattedAddress;
  String addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? zipCode;
  String? county;
  double? latitude;
  double? longitude;
  String? propertyType;
  num? bedrooms; // Changed to num to handle both int and double
  num? bathrooms; // Changed to num to handle both int and double
  double? squareFootage;
  double? lotSize;
  int? yearBuilt;
  String? assessorID;
  String? legalDescription;
  String? subdivision;
  String? zoning;
  DateTime? lastSaleDate;
  double? lastSalePrice;
  Map<String, dynamic>? features;
  Map<String, Map<String, dynamic>>? taxAssessments; // Updated type
  Map<String, dynamic>? propertyTaxes; // Updated type
  Map<String, dynamic>? owner;
  bool? ownerOccupied;
  List<String>? images;

  Property({
    required this.propertyId,
    required this.formattedAddress,
    required this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zipCode,
    this.county,
    this.latitude,
    this.longitude,
    this.propertyType,
    this.bedrooms,
    this.bathrooms,
    this.squareFootage,
    this.lotSize,
    this.yearBuilt,
    this.assessorID,
    this.legalDescription,
    this.subdivision,
    this.zoning,
    this.lastSaleDate,
    this.lastSalePrice,
    this.features,
    this.taxAssessments,
    this.propertyTaxes,
    this.owner,
    this.ownerOccupied,
    this.images,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'formattedAddress': formattedAddress,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'county': county,
      'latitude': latitude,
      'longitude': longitude,
      'propertyType': propertyType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'squareFootage': squareFootage,
      'lotSize': lotSize,
      'yearBuilt': yearBuilt,
      'assessorID': assessorID,
      'legalDescription': legalDescription,
      'subdivision': subdivision,
      'zoning': zoning,
      'lastSaleDate': lastSaleDate,
      'lastSalePrice': lastSalePrice,
      'features': features,
      'taxAssessments': taxAssessments,
      'propertyTaxes': propertyTaxes,
      'owner': owner,
      'ownerOccupied': ownerOccupied,
      'images': images,
    };
  }

  factory Property.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Property(
      propertyId: doc.id,
      formattedAddress: data['formattedAddress'],
      addressLine1: data['addressLine1'],
      addressLine2: data['addressLine2'],
      city: data['city'],
      state: data['state'],
      zipCode: data['zipCode'],
      county: data['county'],
      latitude: data['latitude']?.toDouble(),
      longitude: data['longitude']?.toDouble(),
      propertyType: data['propertyType'],
      bedrooms: data['bedrooms'],
      bathrooms: data['bathrooms'],
      squareFootage: data['squareFootage']?.toDouble(),
      lotSize: data['lotSize']?.toDouble(),
      yearBuilt: data['yearBuilt'],
      assessorID: data['assessorID'],
      legalDescription: data['legalDescription'],
      subdivision: data['subdivision'],
      zoning: data['zoning'],
      lastSaleDate: (data['lastSaleDate'] as Timestamp?)?.toDate(),
      lastSalePrice: data['lastSalePrice']?.toDouble(),
      features: data['features'],
      taxAssessments: (data['taxAssessments'] as Map?)
          ?.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v))), // Updated
      propertyTaxes: Map<String, dynamic>.from(data['propertyTaxes'] ?? {}),
      owner: data['owner'],
      ownerOccupied: data['ownerOccupied'],
      images: List<String>.from(data['images'] ?? []),
    );
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyId: json['id'],
      formattedAddress: json['formattedAddress'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      county: json['county'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      propertyType: json['propertyType'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      squareFootage: json['squareFootage']?.toDouble(),
      lotSize: json['lotSize']?.toDouble(),
      yearBuilt: json['yearBuilt'],
      assessorID: json['assessorID'],
      legalDescription: json['legalDescription'],
      subdivision: json['subdivision'],
      zoning: json['zoning'],
      lastSaleDate: json['lastSaleDate'] != null
          ? DateTime.parse(json['lastSaleDate'])
          : null,
      lastSalePrice: json['lastSalePrice']?.toDouble(),
      features: json['features'],
      taxAssessments: (json['taxAssessments'] as Map?)
          ?.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v))), // Updated
      propertyTaxes: Map<String, dynamic>.from(json['propertyTaxes'] ?? {}),
      owner: json['owner'],
      ownerOccupied: json['ownerOccupied'],
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
