import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/input_field.dart';

class PhoneNumberInputField extends StatelessWidget {
    final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final EdgeInsetsDirectional padding;
  const PhoneNumberInputField({super.key, required this.controller, required this.focusNode, this.validator, this.padding = const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),});

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: controller,
      focusNode: focusNode,
      padding: padding,
      labelText: 'Phone Number (Optional)',
      hintText: 'Enter your phone number here...',
      validator: validator,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        MaskedInputFormatter('(###) ###-####'),

      ],
      
      
    );
  }
}



class MaskedInputFormatter extends TextInputFormatter {
  final String mask;
  MaskedInputFormatter(this.mask);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      // Deleting characters
      return _handleDeletion(oldValue, newValue);
    } else {
      // Adding characters
      return _handleInsertion(oldValue, newValue);
    }
  }

  TextEditingValue _handleInsertion(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    var newText = '';
    var maskIndex = 0;

    for (var i = 0; i < text.length; i++) {
      if (maskIndex >= mask.length) {
        break;
      }
      if (mask[maskIndex] == '#') {
        newText += text[i];
        maskIndex++;
      } else {
        newText += mask[maskIndex];
        maskIndex++;
        i--;
      }
    }

    if (maskIndex < mask.length && mask[maskIndex] != '#') {
      newText += mask[maskIndex];
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  TextEditingValue _handleDeletion(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    var newText = '';
    var maskIndex = 0;

    for (var i = 0; i < text.length; i++) {
      if (maskIndex >= mask.length) {
        break;
      }
      if (mask[maskIndex] == '#') {
        newText += text[i];
        maskIndex++;
      } else {
        newText += mask[maskIndex];
        maskIndex++;
        i--;
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}



