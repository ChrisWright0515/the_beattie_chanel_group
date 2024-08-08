import 'package:flutter/material.dart';
import '../../../components/autocomplete_address_field.dart';
import '../../../components/button.dart';
import '../../../components/logo.dart';
import '../../../components/staggered_list.dart';
import '../../../services/auth_service.dart';
import '../../../utils/address_parser.dart';
import '../../../validator.dart';
import 'confirm_password_input_field.dart';
import 'email_input_field.dart';
import 'name_input_field.dart';
import 'password_input_field.dart';
import 'phone_number_input_field.dart';

class SignUpForm extends StatefulWidget {
  final VoidCallback onLoginTap;

  SignUpForm({
    super.key,
    required this.onLoginTap,
  });

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailAddressTextController =
      TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();

  final FocusNode emailAddressFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

  String? validatedAddress;

  void _onAddressValidated(String? address) {
    setState(() {
      validatedAddress = address;
    });
  }

  Future<void> _onSignUpPressed() async {
    if (_formKey.currentState!.validate()) {
      print(
          'Name: ${nameTextController.text}, Email: ${emailAddressTextController.text}, Phone: ${phoneNumberTextController.text}, Address: $validatedAddress, Password: ${passwordTextController.text}');
      var formattedAddress =
          AddressParser.parseFormattedAddress(validatedAddress ?? '');
      print('Formatted Address: $formattedAddress');
      String address = formattedAddress['address'] ?? '';
      String city = formattedAddress['city'] ?? '';
      String state = formattedAddress['state'] ?? '';
      String zipCode = formattedAddress['zipCode'] ?? '';

      final result = await _authService.signUpWithEmail(
        nameTextController.text,
        emailAddressTextController.text,
        passwordTextController.text,
        'client',
        phoneNumberTextController.text,
        address,
        city,
        state,
        zipCode,
      );

      if (result['result'] == 'failed') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']!),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Handle successful sign-up
        // clear the form
        nameTextController.clear();
        emailAddressTextController.clear();
        phoneNumberTextController.clear();
        addressTextController.clear();
        passwordTextController.clear();
        confirmPasswordTextController.clear();

        // Send verification email
        // await _authService.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up Successful'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StaggeredList(
        delay: const Duration(milliseconds: 200),
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: LogoTextRow(),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Get Started,',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(letterSpacing: 0.0),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                NameInputField(
                  controller: nameTextController,
                  focusNode: nameFocusNode,
                  // validator: Validator.validateSignUpName,
                ),
                EmailInputField(
                  controller: emailAddressTextController,
                  focusNode: emailAddressFocusNode,
                  validator: Validator.validateSignUpEmail,
                ),
                PhoneNumberInputField(
                  controller: phoneNumberTextController,
                  focusNode: phoneNumberFocusNode,
                  validator: Validator.validateSignUpPhoneNumber,
                ),
                AutoCompleteAddressField(
                  controller: addressTextController,
                  onAddressValidated: _onAddressValidated,
                  focusNode: addressFocusNode,
                ),
                PasswordInputField(
                  controller: passwordTextController,
                  focusNode: passwordFocusNode,
                  validator: Validator.validateSignUpPassword,
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                ),
                ConfirmPasswordInputField(
                  controller: confirmPasswordTextController,
                  focusNode: confirmPasswordFocusNode,
                  validator: (value) => Validator.validateSignUpConfirmPassword(
                      value, passwordTextController),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 4.0, 6.0),
            child: Button(
              onPressed: _onSignUpPressed,
              text: 'Sign Up',
              options: ButtonOptions(
                width: 130.0,
                height: 50.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0.0,
                hoverColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Button(
                  onPressed: widget.onLoginTap,
                  text: 'Login',
                  options: ButtonOptions(
                    width: 75.0,
                    height: 30.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 0.0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 0.0),
                    color: const Color(0x00FFFFFF),
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.primary,
                    ),
                    elevation: 0.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
