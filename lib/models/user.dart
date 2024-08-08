import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String? name;
  String email;
  String? phoneNumber;
  String passwordHash;
  String salt;
  String? profilePictureUrl;
  String role;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  bool emailVerified;

  User({
    required this.id,
    this.name,
    required this.email,
    this.phoneNumber,
    required this.passwordHash,
    required this.salt,
    this.profilePictureUrl,
    required this.role,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.emailVerified = false,
  });

  // Add copyWith method
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? passwordHash,
    String? salt,
    String? profilePictureUrl,
    String? role,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    bool? emailVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      passwordHash: passwordHash ?? this.passwordHash,
      salt: salt ?? this.salt,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      role: role ?? this.role,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  // From Firestore document to User object
  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return User(
      id: doc.id,
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phone_number'],
      passwordHash: data['password_hash'],
      salt: data['salt'],
      profilePictureUrl: data['profile_picture_url'],
      role: data['role'],
      address: data['address'],
      city: data['city'],
      state: data['state'],
      zipCode: data['zip_code'],
      emailVerified: data['email_verified'] ?? false,
    );
  }

  // From User object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password_hash': passwordHash,
      'salt': salt,
      'profile_picture_url': profilePictureUrl,
      'role': role,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'email_verified': emailVerified,
    };
  }

  // to string
  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, passwordHash: $passwordHash, salt: $salt, profilePictureUrl: $profilePictureUrl, role: $role, address: $address, city: $city, state: $state, zipCode: $zipCode, emailVerified: $emailVerified}';
  }

  // to json and from json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'passwordHash': passwordHash,
      'salt': salt,
      'profilePictureUrl': profilePictureUrl,
      'role': role,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'emailVerified': emailVerified,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      passwordHash: json['passwordHash'],
      salt: json['salt'],
      profilePictureUrl: json['profilePictureUrl'],
      role: json['role'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      emailVerified: json['emailVerified'],
    );
  }

// Get full address
  String getFullAddress() {
    if (address != null && city != null && state != null && zipCode != null) {
      return '$address, $city, $state, $zipCode';
    } else {
      return '';
    }
  }
}
