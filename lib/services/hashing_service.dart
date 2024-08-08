// lib/services/hashing_service.dart
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';

class HashingService {
  // Generate a random salt
  String generateSalt([int length = 16]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  // Hash the password using PBKDF2
  String hashPassword(String password, String salt) {
    final key = utf8.encode(password);
    final saltBytes = utf8.encode(salt);

    final hmac = Hmac(sha256, key);
    final hash = pbkdf2(hmac, key, saltBytes, 10000, 32);
    return base64Url.encode(hash);
  }

  // PBKDF2 implementation
  List<int> pbkdf2(Hmac hmac, List<int> password, List<int> salt,
      int iterations, int length) {
    var key = List<int>.from(password);
    var output = List<int>.filled(length, 0);

    for (int i = 0; i < iterations; i++) {
      key = hmac.convert([...key, ...salt]).bytes;
      for (int j = 0; j < length; j++) {
        output[j] ^= key[j % key.length];
      }
    }
    return output;
  }
}
