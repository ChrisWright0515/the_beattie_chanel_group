import 'dart:convert';

import 'package:flutter/material.dart';

import 'services/api_service.dart';
import 'services/perspective_service.dart';
// import 'package:email_validator/email_validator.dart';

class Validator {
  /// Validates the email for login.
  /// Returns an error message if the email is invalid, otherwise returns null.
  static String? validateLoginEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // if (!EmailValidator.validate(value)) {
    //   return 'Enter a valid email';
    // }
    return null;
  }

  /// Validates the password for login.
  /// Returns an error message if the password is invalid, otherwise returns null.
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  /// Validates the email for sign-up.
  /// Returns an error message if the email is invalid, otherwise returns null.
  static String? validateSignUpEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // if (!EmailValidator.validate(value)) {
    //   return 'Enter a valid email';
    // }
    return null;
  }

  /// Validates the name for sign-up.
  /// Returns an error message if the name is invalid, otherwise returns null.
  static String? validateSignUpName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  static Future<String?> validateNameField(
      String? value, PerspectiveApiService apiService) async {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    try {
      final response = await apiService.analyzeComment(value);
      final toxicityScore =
          response['attributeScores']['TOXICITY']['summaryScore']['value'];
      if (toxicityScore > 0.7) {
        return 'Inappropriate content detected';
      }
    } catch (e) {
      return 'Error analyzing content';
    }
    return null;
  }

  /// Validates the phone number for sign-up.
  /// Returns an error message if the phone number is invalid, otherwise returns null.
  static String? validateSignUpPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Field is optional, so it's valid if empty
    }

    // Regular expression to match (###) ###-####
    final phoneRegExp = RegExp(r'^\(\d{3}\) \d{3}-\d{4}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number in the format (###) ###-####';
    }

    return null; // Field is valid
  }

  /// Validates the password for sign-up.
  /// Returns an error message if the password is invalid, otherwise returns null.
  static String? validateSignUpPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    bool hasNumber = value.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacter =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!hasLowercase) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!hasNumber) {
      return 'Password must contain at least one number';
    }
    if (!hasSpecialCharacter) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  /// Validates the confirmation of the password.
  /// Returns an error message if the passwords do not match, otherwise returns null.
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates the confirmation of the password during sign-up.
  /// Returns an error message if the passwords do not match, otherwise returns null.
  static String? validateSignUpConfirmPassword(
      String? value, TextEditingController passwordController) {
    return Validator.validateConfirmPassword(value, passwordController.text);
  }

  /// Validates a username.
  /// Returns an error message if the username is invalid, otherwise returns null.
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 4) {
      return 'Username must be at least 4 characters';
    }
    return null;
  }

  /// Validates a date in the format YYYY-MM-DD.
  /// Returns an error message if the date is invalid, otherwise returns null.
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    final dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegExp.hasMatch(value)) {
      return 'Enter a valid date in the format YYYY-MM-DD';
    }
    return null;
  }

  /// Validates the sign-up address.
  /// Returns an error message if the address is invalid, otherwise returns null.
  static String? validateSignUpAddress(String? value, String? placeId) {
    if (value == null || value.isEmpty) {
      return null;
    }
    // Simple regex to check if the address format is correct
    final addressRegex =
        RegExp(r'^[0-9]+ [a-zA-Z ]+, [a-zA-Z ]+, [A-Z]{2} [0-9]{5}, USA$');
    if (!addressRegex.hasMatch(value)) {
      return 'Enter a valid address format';
    }
    if (placeId == null || placeId.isEmpty) {
      return 'Address must be validated with a placeId';
    }
    return null;
  }
}
