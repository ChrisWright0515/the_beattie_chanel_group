import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final EdgeInsetsDirectional padding;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Key? formFieldKey;

  const InputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.padding = const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
    this.prefixIcon,
    this.onChanged,
    this.inputFormatters, this.formFieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              key: formFieldKey,
              controller: controller,
              focusNode: focusNode,
              obscureText: obscureText,
              validator: validator,
              onChanged: onChanged,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
