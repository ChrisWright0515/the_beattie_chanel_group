import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../screens/welcome/welcome_screen.dart';
import 'button.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
      child: Button(
        onPressed: () async {
          await Provider.of<AuthProvider>(context, listen: false).signOut();
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              WelcomeScreen.routeName,
              (Route<dynamic> route) => false,
            );
          }
        },
        text: 'Log Out',
        options: ButtonOptions(
          width: 110,
          height: 50,
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: Theme.of(context).colorScheme.secondary,
          textStyle: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Colors.white,
            fontSize: 16,
            letterSpacing: 0,
          ),
          elevation: 0,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
