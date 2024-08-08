import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class Environment {
  static const _storage = FlutterSecureStorage();

  static Future<void> loadEnv({required bool isProduction}) async {
    final fileName = isProduction ? '.env.production' : '.env.development';
    // print('Loading .env file: $fileName');

    try {
      await dotenv.load(fileName: fileName);
      // printPlatform();

      await _storeApiKey('GOOGLE_MAP_API_KEY');
      await _storeOAuthCredentials('GOOGLE_OAUTH_CLIENT_ID');
    } catch (e) {
      // print('Error loading .env file: $e');
    }
  }

  static Future<void> _storeApiKey(String apiKeyBase) async {
    String? apiKey = _getPlatformSpecificKey(apiKeyBase);

    if (apiKey != null) {
      await _storage.write(key: apiKeyBase, value: apiKey);
    } else {
      throw Exception('$apiKeyBase is missing for the platform');
    }
  }

  static Future<void> _storeOAuthCredentials(String clientIdBase) async {
    String? clientId = dotenv.env[clientIdBase];

    if (clientId != null) {
      await _storage.write(key: clientIdBase, value: clientId);
    } else {
      throw Exception('$clientIdBase is missing');
    }
  }

  static Future<String?> getOAuthClientId() async {
    return await _storage.read(key: 'GOOGLE_OAUTH_CLIENT_ID');
  }

  static String? _getPlatformSpecificKey(String keyBase) {
    if (kIsWeb) {
      return dotenv.env['${keyBase}_WEB'];
    } else if (Platform.isAndroid) {
      return dotenv.env['${keyBase}_ANDROID'];
    } else if (Platform.isIOS) {
      return dotenv.env['${keyBase}_IOS'];
    } else if (Platform.isMacOS) {
      return dotenv.env['${keyBase}_MACOS'];
    } else if (Platform.isWindows) {
      return dotenv.env['${keyBase}_WINDOWS'];
    } else if (Platform.isLinux) {
      return dotenv.env['${keyBase}_LINUX'];
    } else {
      throw Exception('Unsupported platform');
    }
  }

  static String? getSpecificKey(String keyBase) {
    return dotenv.env[keyBase];
  }

  static Future<String?> getApiKey(String apiKeyBase) async {
    return await _storage.read(key: apiKeyBase);
  }

  static Future<String?> getOAuthClientSecret() async {
    return await _getOAuthCredential('GOOGLE_OAUTH_CLIENT_SECRET');
  }

  static Future<String?> _getOAuthCredential(String credentialBase) async {
    String? platformKey = _getPlatformSpecificKey(credentialBase);
    return platformKey != null
        ? await _storage.read(key: credentialBase)
        : null;
  }
}

// void printPlatform() {
//   if (kIsWeb) {
//     print('Running on: Web');
//   } else if (Platform.isAndroid) {
//     print('Running on: Android');
//   } else if (Platform.isIOS) {
//     print('Running on: iOS');
//   } else if (Platform.isMacOS) {
//     print('Running on: macOS');
//   } else if (Platform.isWindows) {
//     print('Running on: Windows');
//   } else if (Platform.isLinux) {
//     print('Running on: Linux');
//   } else {
//     print('Running on: Unknown platform');
//   }
// }
