// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../models/user.dart';
// import '../services/auth_service.dart';

// class AuthProvider extends ChangeNotifier {
//   User? _user;
//   final _storage = const FlutterSecureStorage();
//   bool _isUserLoaded = false;
//   bool _isLoading = false;

//   User? get user => _user;
//   bool get isAuthenticated => _user != null;
//   bool get isUserLoaded => _isUserLoaded;

//   AuthProvider() {
//     loadUser();
//   }

//   Future<void> signIn(String email, String password) async {
//     final result = await AuthService().signInWithEmail(email, password);

//     if (result['result'] == 'success') {
//       _user = result['user'];
//       await _saveUser();
//       notifyListeners();
//     } else {
//       throw Exception(result['message']);
//     }
//   }

//   bool _isSigningIn = false;

//   Future<void> signInWithGoogle() async {
//     if (_isSigningIn) return;

//     try {
//       _isSigningIn = true;
//       final result = await AuthService().signInWithGoogle();

//       if (result['result'] == 'success') {
//         final user = await AuthService().getUserDetails();
//         _user = user;
//         await _saveUser();
//         notifyListeners();
//       } else {
//         throw Exception(result['message']);
//       }
//     } finally {
//       _isSigningIn = false;
//     }
//   }

//   Future<void> signOut() async {
//     await AuthService().signOut();
//     _user = null;
//     await _clearUser();
//     notifyListeners();
//   }

//   Future<void> updateUser(User updatedUser) async {
//     _user = updatedUser;
//     await _saveUser();
//     notifyListeners();
//   }

//   Future<void> _saveUser() async {
//     if (_user != null) {
//       String userJson = jsonEncode(_user!.toJson());
//       await _storage.write(key: 'user', value: userJson);
//     }
//   }

//   Future<void> loadUser() async {
//     if (_isLoading) return;
//     _isLoading = true;

//     final userJson = await _storage.read(key: 'user');
//     if (userJson != null) {
//       _user = User.fromJson(jsonDecode(userJson));
//       print('User logged in: ${_user!.toJson()}');
//     } else {
//       print('User not logged in');
//     }
//     _isUserLoaded = true;
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> _clearUser() async {
//     await _storage.delete(key: 'user');
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  final _storage = const FlutterSecureStorage();
  bool _isUserLoaded = false;
  bool _isLoading = false;
  bool _isSigningIn = false;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isUserLoaded => _isUserLoaded;

  AuthProvider() {
    loadUser();
  }

  Future<void> signIn(String email, String password) async {
    final result = await AuthService().signInWithEmail(email, password);

    if (result['result'] == 'success') {
      _user = result['user'];
      await _saveUser();
      notifyListeners();
    } else {
      throw Exception(result['message']);
    }
  }

  Future<void> signInWithGoogle() async {
    if (_isSigningIn) return;

    try {
      _isSigningIn = true;
      final result = await AuthService().signInWithGoogle();

      if (result['result'] == 'success') {
        final user = await AuthService().getUserDetails();
        _user = user;
        await _saveUser();
        notifyListeners();
      } else {
        throw Exception(result['message']);
      }
    } finally {
      _isSigningIn = false;
    }
  }

  Future<void> signOut() async {
    await AuthService().signOut();
    _user = null;
    await _clearUser();
    notifyListeners();
  }

  Future<void> updateUser(User updatedUser) async {
    _user = updatedUser;
    await _saveUser();
    notifyListeners();
  }

  Future<void> updateUserProfilePicture(String profilePictureUrl) async {
    if (_user != null) {
      _user = _user!.copyWith(profilePictureUrl: profilePictureUrl);
      await _saveUser();
      notifyListeners();
    }
  }

  Future<void> _saveUser() async {
    if (_user != null) {
      String userJson = jsonEncode(_user!.toJson());
      await _storage.write(key: 'user', value: userJson);
    }
  }

  Future<void> loadUser() async {
    if (_isLoading) return;
    _isLoading = true;

    final userJson = await _storage.read(key: 'user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      final userId = userMap['id'];

      // Fetch the user from Firestore using the stored ID
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        _user = User.fromFirestore(doc);
        print('User logged in: ${_user!.toJson()}');
      } else {
        print('User not found in Firestore');
      }
    } else {
      print('User not logged in');
    }

    _isUserLoaded = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _clearUser() async {
    await _storage.delete(key: 'user');
  }
}
