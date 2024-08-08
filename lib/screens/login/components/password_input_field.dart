import 'package:flutter/material.dart';

import '../../../components/input_field.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final EdgeInsetsDirectional padding;
    final GlobalKey<FormFieldState>? formFieldKey;


  const PasswordInputField({
    super.key,
    required this.controller,
    required this.focusNode, this.validator,
    this.padding = const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0), this.formFieldKey,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return InputField(
      formFieldKey: widget.formFieldKey,
      controller: widget.controller,
      focusNode: widget.focusNode,
      // padding: widget.padding,
      labelText: 'Password',
      hintText: 'Enter your password here...',
      obscureText: _isPasswordObscure,
      validator: widget.validator,
      suffixIcon: InkWell(
        onTap: () {
          setState(() {
            _isPasswordObscure = !_isPasswordObscure;
          });
        },
        focusNode: FocusNode(skipTraversal: true),
        child: Icon(
          _isPasswordObscure
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: const Color(0xFF95A1AC),
          size: 22.0,
        ),
      ),
    );
  }
}
