import 'package:flutter/material.dart';

import '../../../components/input_field.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final EdgeInsetsDirectional padding;
    final GlobalKey<FormFieldState>? formFieldKey;


  const EmailInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.validator,
    this.padding = const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0), this.formFieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return InputField(
      formFieldKey: formFieldKey,
      controller: controller,
      focusNode: focusNode,
      labelText: 'Email',
      hintText: 'Enter your email here...',
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      padding: padding,
    );
  }
}
