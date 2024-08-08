import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/button.dart';
import '../../../components/logo.dart';
import '../../../components/staggered_list.dart';
import '../../../constants.dart';
import '../../../provider/auth_provider.dart';
import '../../../services/auth_service.dart';
import '../../../validator.dart';
import '../../agent_home/agent_home_screen.dart';
import '../../client_home/client_home_screen.dart';
import 'email_input_field.dart';
import 'password_input_field.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSignUpTap;

  LoginForm({
    super.key,
    required this.onSignUpTap,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode emailAddressFocusNode = FocusNode();
  final TextEditingController emailAddressTextController =
      TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StaggeredList(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: LogoTextRow(),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back,',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(letterSpacing: 0.0),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 10.0),
              child: Button(
                onPressed: _onGoogleTap,
                text: 'Continue with Google',
                iconPath: 'assets/icons/g_logo.svg',
                options: ButtonOptions(
                  iconSize: 20,
                  width: double.infinity,
                  height: 50.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      10.0, 0.0, 10.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Colors.white, // Google color
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 1.0,
                  hoverElevation: 4.0,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              child: Button(
                onPressed: _onFacebookTap,
                text: 'Continue with Facebook',
                iconPath: 'assets/icons/f_logo.svg',
                options: ButtonOptions(
                  iconSize: 20,
                  width: double.infinity,
                  height: 50.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      10.0, 0.0, 10.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: const Color(0xFF1877F2), // Facebook color
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 0.0,
                  hoverElevation: 4.0,
                  hoverColor: const Color(0xFF1877F2), // Facebook color lighter
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Or',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        letterSpacing: 0.0,
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  EmailInputField(
                    controller: emailAddressTextController,
                    focusNode: emailAddressFocusNode,
                    validator: (value) {
                      if (_emailErrorMessage != null) {
                        return _emailErrorMessage;
                      }
                      return Validator.validateLoginEmail(value);
                    },
                  ),
                  PasswordInputField(
                    controller: passwordTextController,
                    focusNode: passwordFocusNode,
                    validator: (value) {
                      if (_passwordErrorMessage != null) {
                        return _passwordErrorMessage;
                      }
                      return Validator.validateLoginPassword(value);
                    },
                  ),
                ],
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 5.0, 0.0),
                      child: Button(
                        onPressed: () {},
                        text: 'Forgot Password',
                        options: ButtonOptions(
                          width: double.infinity,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: buttonPrimary.withOpacity(0.3),
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 0.0,
                          hoverElevation: 0.0,
                          hoverColor: buttonPrimary.withOpacity(0.6),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          5.0, 0.0, 0.0, 0.0),
                      child: Button(
                        onPressed: _onLoginTap,
                        text: 'Login',
                        options: ButtonOptions(
                          width: double.infinity,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.6),
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 0.0,
                          hoverColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.8),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 10.0, 0.0),
                        child: Text(
                          'Don\'t have an account?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Button(
                        onPressed: widget.onSignUpTap,
                        text: 'Sign Up',
                        options: ButtonOptions(
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
                            decorationColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          elevation: 0.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onLoginTap() async {
    setState(() {
      _emailErrorMessage = null;
      _passwordErrorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      try {
        AuthProvider currentUser =
            Provider.of<AuthProvider>(context, listen: false);
        await currentUser.signIn(
          emailAddressTextController.text,
          passwordTextController.text,
        );

        // Check user authentication status
        if (currentUser.isAuthenticated) {
          String role = currentUser.user!.role;

          if (role == 'agent') {
            Navigator.pushReplacementNamed(context, AgentHomeScreen.routeName);
          } else {
            Navigator.pushReplacementNamed(context, ClientHomeScreen.routeName);
          }
        }
      } catch (e) {
        setState(() {
          if (e.toString().contains('email')) {
            _emailErrorMessage = e.toString();
          } else if (e.toString().contains('password')) {
            _passwordErrorMessage = e.toString();
          }
          _formKey.currentState!
              .validate(); // Re-trigger validation to show the errors
        });
      }
    }
  }

  Future<void> _onGoogleTap() async {
    try {
      AuthProvider currentUser =
          Provider.of<AuthProvider>(context, listen: false);
      await currentUser.signInWithGoogle();

      if (currentUser.isAuthenticated) {
        String role = currentUser.user!.role;

        if (role == 'agent') {
          if (mounted) {
            Navigator.pushReplacementNamed(context, AgentHomeScreen.routeName);
          }
        } else {
          if (mounted) {
            Navigator.pushReplacementNamed(context, ClientHomeScreen.routeName);
          }
        }
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().contains('message')
                ? e.toString()
                : 'An error occurred during sign-in'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  _onFacebookTap() {}
}
