// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/user.dart';
// import 'hashing_service.dart';
// import '../utils/address_parser.dart';

// class UserService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final HashingService _hashingService = HashingService();

//   Future<void> addUser({
//     required String id,
//     String? name,
//     required String email,
//     String? phoneNumber,
//     required String password,
//     String? profilePictureUrl,
//     String? role,
//     String? formattedAddress, // Include formattedAddress as an input
//   }) async {
//     CollectionReference users = _firestore.collection('users');
//     // Default role

//     role == 'agent' ? 'agent' : 'client';
//     // Generate salt and hash the password
//     String salt = _hashingService.generateSalt();
//     String hashedPassword = _hashingService.hashPassword(password, salt);

//     // Parse the formatted address
//     String? address;
//     String? city;
//     String? state;
//     String? zipCode;

//     if (formattedAddress != null && formattedAddress.isNotEmpty) {
//       final addressComponents =
//           AddressParser.parseFormattedAddress(formattedAddress);
//       address = addressComponents['address'];
//       city = addressComponents['city'];
//       state = addressComponents['state'];
//       zipCode = addressComponents['zipCode'];
//     }

//     // Create a User object with hashed password
//     User user = User(
//       id: id,
//       name: name,
//       email: email,
//       phoneNumber: phoneNumber,
//       passwordHash: hashedPassword,
//       salt: salt,
//       profilePictureUrl: profilePictureUrl,
//       role: role!,
//       address: address,
//       city: city,
//       state: state,
//       zipCode: zipCode,
//     );

//     try {
//       await users.doc(user.id).set(user.toFirestore());
//       print("User Added");
//     } catch (e) {
//       print("Failed to add user: $e");
//     }
//   }

//   // get user stream
//   Stream<User> getUser(String userId) {
//     return _firestore.collection('users').doc(userId).snapshots().map((doc) {
//       if (doc.exists) {
//         return User.fromFirestore(doc);
//       } else {
//         throw Exception('User not found');
//       }
//     }).where((user) => user != null);
//   }

//   updateUser(String id, {required String? name, required String? email, required String? phoneNumber, required String? address, required String? city, required String? state, required String? zipCode}) {}

//   updateUserPicture(String userId, {required String profilePictureUrl}) {
//     _firestore.collection('users').doc(userId).update({
//       'profile_picture_url': profilePictureUrl,
//     });
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'hashing_service.dart';
import '../utils/address_parser.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HashingService _hashingService = HashingService();

  Future<void> addUser({
    required String id,
    String? name,
    required String email,
    String? phoneNumber,
    required String password,
    String? profilePictureUrl,
    String? role,
    String? formattedAddress,
  }) async {
    CollectionReference users = _firestore.collection('users');

    // Generate salt and hash the password
    String salt = _hashingService.generateSalt();
    String hashedPassword = _hashingService.hashPassword(password, salt);

    // Parse the formatted address
    String? address;
    String? city;
    String? state;
    String? zipCode;

    if (formattedAddress != null && formattedAddress.isNotEmpty) {
      final addressComponents =
          AddressParser.parseFormattedAddress(formattedAddress);
      address = addressComponents['address'];
      city = addressComponents['city'];
      state = addressComponents['state'];
      zipCode = addressComponents['zipCode'];
    }

    // Create a User object with hashed password
    User user = User(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      passwordHash: hashedPassword,
      salt: salt,
      profilePictureUrl: profilePictureUrl,
      role: role ?? 'client',
      address: address,
      city: city,
      state: state,
      zipCode: zipCode,
    );

    try {
      await users.doc(user.id).set(user.toFirestore());
      print("User Added");
    } catch (e) {
      print("Failed to add user: $e");
    }
  }

  // Get user stream
  Stream<User> getUser(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return User.fromFirestore(doc);
      } else {
        throw Exception('User not found');
      }
    });
  }

  // Update user details
  Future<void> updateUser({
    required String id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? city,
    String? state,
    String? zipCode,
  }) async {
    Map<String, dynamic> updateData = {};
    if (name != null) updateData['name'] = name;
    if (email != null) updateData['email'] = email;
    if (phoneNumber != null) updateData['phone_number'] = phoneNumber;
    if (address != null) updateData['address'] = address;
    if (city != null) updateData['city'] = city;
    if (state != null) updateData['state'] = state;
    if (zipCode != null) updateData['zip_code'] = zipCode;

    return _firestore.collection('users').doc(id).update(updateData);
  }

  // Update user profile picture
  Future<void> updateUserPicture({
    required String userId,
    required String profilePictureUrl,
  }) async {
    return _firestore.collection('users').doc(userId).update({
      'profile_picture_url': profilePictureUrl,
    });
  }
}
