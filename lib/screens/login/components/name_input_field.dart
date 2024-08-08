// import 'package:flutter/material.dart';

import '../../../components/input_field.dart';

// class NameInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final String? Function(String?)? validator;
//   const NameInputField({super.key, required this.controller, required this.focusNode, this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return InputField(
//       controller: controller,
//       focusNode: focusNode,
//       labelText: 'Full Name',
//       hintText: 'Enter your full name here...',
//       validator: validator,
//       keyboardType: TextInputType.name,
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../services/api_service.dart';
import '../../../services/perspective_service.dart';
import '../../../validator.dart';

class NameInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const NameInputField({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  _NameInputFieldState createState() => _NameInputFieldState();
}

class _NameInputFieldState extends State<NameInputField> {
  String? _errorText;
  late PerspectiveApiService _perspectiveApiService;

  @override
  void initState() {
    super.initState();
    // Initialize PerspectiveApiService
    final apiService =
        ApiService(baseUrl: 'https://commentanalyzer.googleapis.com/v1alpha1');
    _perspectiveApiService = PerspectiveApiService(apiService: apiService);
  }

  Future<void> _validateName(String value) async {
    final validationResult =
        await Validator.validateNameField(value, _perspectiveApiService);
    setState(() {
      _errorText = validationResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      labelText: 'Full Name',
      hintText: 'Enter your full name here...',
      keyboardType: TextInputType.name,
      onChanged: (value) {
        _validateName(value);
      },
      validator: (_) => _errorText,
    );
  }
}
