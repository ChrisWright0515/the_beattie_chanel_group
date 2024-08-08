import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import '../models/user.dart';
import 'hashing_service.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HashingService _hashingService = HashingService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb ? dotenv.env['GOOGLE_CLIENT_ID_WEB'] : null,
  );

  // Sign up with email and password
  Future<Map<String, String>> signUpWithEmail(
      String name,
      String email,
      String password,
      String role,
      String? phoneNumber,
      String? address,
      String? city,
      String? state,
      String? zipCode) async {
    try {
      // Check if the email is already in use
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isNotEmpty) {
        return {'result': 'failed', 'message': 'Email is already in use'};
      }

      auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      String salt = _hashingService.generateSalt();
      String hashedPassword = _hashingService.hashPassword(password, salt);

      User newUser = User(
        id: user.uid,
        name: name,
        email: email,
        passwordHash: hashedPassword,
        salt: salt,
        role: role,
        phoneNumber: phoneNumber,
        profilePictureUrl: user.photoURL,
        address: address,
        city: city,
        state: state,
        zipCode: zipCode,
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(newUser.toFirestore());

      // Send email verification
      await user.sendEmailVerification();

      print("User signed up and created in Firestore");

      return {
        'result': 'success',
        'message': 'User signed up successfully. Please verify your email.'
      };
    } catch (e) {
      print("Error signing up: $e");
      return {
        'result': 'failed',
        'message': 'An error occurred during sign-up'
      };
    }
  }

  Future<Map<String, dynamic>> signInWithEmail(
      String email, String password) async {
    try {
      // Get user document from Firestore
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isEmpty) {
        return {
          'result': 'failed',
          'message': 'No user found with this email',
          'field': 'email'
        };
      }

      var userDoc = query.docs.first;
      var user = User.fromFirestore(userDoc);

      // Hash the input password with the stored salt
      String hashedPassword = _hashingService.hashPassword(password, user.salt);

      // Compare hashed password with stored password
      if (hashedPassword == user.passwordHash) {
        auth.UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final auth.User firebaseUser = userCredential.user!;

        // Check if the email is verified in Firestore
        if (!user.emailVerified && !firebaseUser.emailVerified) {
          await _firebaseAuth.signOut();
          return {
            'result': 'failed',
            'field': 'email',
            'message': 'Email not verified. Please check your inbox.'
          };
        }

        print("User signed in successfully");
        // Return success message and User object
        return {
          'result': 'success',
          'message': 'User signed in successfully',
          'user': user
        };
      } else {
        return {
          'result': 'failed',
          'message': 'Invalid Credentials',
          'field': 'both'
        }; // invalid password
      }
    } catch (e) {
      print("Error signing in with email: $e");
      return {
        'result': 'failed',
        'message': 'An error occurred during sign-in',
        'field': 'both'
      };
    }
  }

  // Future<Map<String, dynamic>> signInWithGoogle() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) {
  //       return {'result': 'failed', 'message': 'Google Sign-In aborted'};
  //     }
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final credential = auth.GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     auth.UserCredential userCredential =
  //         await _firebaseAuth.signInWithCredential(credential);
  //     bool isNewUser = await _fetchOrCreateUser(userCredential.user!);
  //     return {
  //       'result': 'success',
  //       'message': 'User signed in with Google successfully',
  //       'isNewUser': isNewUser.toString(),
  //     };
  //   } catch (e) {
  //     print('Error: $e');
  //     return {
  //       'result': 'failed',
  //       'message': 'An error occurred during Google sign-in'
  //     };
  //   }
  // }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {'result': 'failed', 'message': 'Google Sign-In aborted'};
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      bool isNewUser = await _fetchOrCreateUser(userCredential.user!);
      return {
        'result': 'success',
        'message': 'User signed in with Google successfully',
        'isNewUser': isNewUser.toString(),
      };
    } catch (e) {
      print('Error: $e');
      return {
        'result': 'failed',
        'message': 'An error occurred during Google sign-in'
      };
    }
  }

  
  // Fetch or create user in Firestore
  Future<bool> _fetchOrCreateUser(auth.User firebaseUser) async {
    DocumentReference userRef =
        _firestore.collection('users').doc(firebaseUser.uid);
    DocumentSnapshot userDoc = await userRef.get();

    if (!userDoc.exists) {
      // Create a new user in Firestore
      User user = User(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? 'Guest',
        email: firebaseUser.email ?? '',
        passwordHash:
            '', // Password is not stored for OAuth and anonymous users
        salt: '',
        role: 'client', // Role set to 'guest'
        phoneNumber:
            firebaseUser.phoneNumber, // Store phone number if available
        profilePictureUrl:
            firebaseUser.photoURL, // Store photo URL if available
        address: null,
        city: null,
        state: null,
        zipCode: null,
        emailVerified: true, // Set emailVerified to true for OAuth users
      );

      await userRef.set(user.toFirestore());
      return true; // User was created
    } else {
      // Update emailVerified field if it is an existing user
      await userRef.update({'email_verified': true});
      return false; // User already existed
    }
  }

  // get user details
  Future<User> getUserDetails() async {
    auth.User? firebaseUser = _firebaseAuth.currentUser;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(firebaseUser!.uid).get();
    return User.fromFirestore(userDoc);
  }

  // Sign out
  Future<void> signOut() async {
    // Check if the user is signed in with Google
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
    await _firebaseAuth.signOut();
  }
}
