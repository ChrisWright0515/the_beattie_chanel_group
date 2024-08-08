import 'package:cloud_firestore/cloud_firestore.dart';

class Listing {
  String listingId;
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
  num? bedrooms;
  num? bathrooms;
  double? squareFootage;
  double? lotSize;
  int? yearBuilt;
  String? status;
  double? price;
  DateTime? listedDate;
  DateTime? removedDate;
  DateTime? createdDate;
  DateTime? lastSeenDate;
  int? daysOnMarket;
  List<String>? images;
  String? agentId;

  Listing({
    required this.listingId,
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
    this.status,
    this.price,
    this.listedDate,
    this.removedDate,
    this.createdDate,
    this.lastSeenDate,
    this.daysOnMarket,
    this.images,
    this.agentId,
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
      'status': status,
      'price': price,
      'listedDate': listedDate,
      'removedDate': removedDate,
      'createdDate': createdDate,
      'lastSeenDate': lastSeenDate,
      'daysOnMarket': daysOnMarket,
      'images': images,
      'agentId': agentId,
    };
  }

  factory Listing.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Listing(
      listingId: doc.id,
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
      status: data['status'],
      price: data['price']?.toDouble(),
      listedDate: (data['listedDate'] as Timestamp?)?.toDate(),
      removedDate: (data['removedDate'] as Timestamp?)?.toDate(),
      createdDate: (data['createdDate'] as Timestamp?)?.toDate(),
      lastSeenDate: (data['lastSeenDate'] as Timestamp?)?.toDate(),
      daysOnMarket: data['daysOnMarket'],
      images: List<String>.from(data['images'] ?? []),
      agentId: data['agentId'],
    );
  }

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      listingId: json['id'],
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
      status: json['status'],
      price: json['price']?.toDouble(),
      listedDate: json['listedDate'] != null
          ? DateTime.parse(json['listedDate'])
          : null,
      removedDate: json['removedDate'] != null
          ? DateTime.parse(json['removedDate'])
          : null,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      lastSeenDate: json['lastSeenDate'] != null
          ? DateTime.parse(json['lastSeenDate'])
          : null,
      daysOnMarket: json['daysOnMarket'],
      images: List<String>.from(json['images'] ?? []),
      agentId: json['agentId'],
    );
  }
}
