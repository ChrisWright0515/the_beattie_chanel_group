import 'package:flutter/material.dart';

import '../../../components/input_field.dart';

class ConfirmPasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;

  const ConfirmPasswordInputField({
    super.key,
    required this.controller,
    required this.focusNode, this.validator,
  });

  @override
  State<ConfirmPasswordInputField> createState() =>
      _ConfirmPasswordInputFieldState();
}

class _ConfirmPasswordInputFieldState extends State<ConfirmPasswordInputField> {
  bool _isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      // padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
      labelText: 'Confirm Password',
      hintText: 'Confirm your password here...',
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
