import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'firebase_options.dart';
import 'provider/auth_provider.dart';
import 'provider/theme_provider.dart';
import 'routes.dart';
import 'screens/agent_home/agent_home_screen.dart';
import 'screens/client_home/client_home_screen.dart';
import 'screens/welcome/welcome_screen.dart';
import 'environment.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  const isProduction = String.fromEnvironment('FLAVOR') == 'production';

  await Environment.loadEnv(isProduction: isProduction);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('Firebase initialized successfully');
  } catch (error) {
    print('Failed to initialize Firebase: $error');
    FlutterNativeSplash.remove();
    return;
  }

  FlutterNativeSplash.remove();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig.init(constraints, orientation);
            return Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                if (!authProvider.isUserLoaded) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return _buildMaterialApp(context, authProvider);
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _buildMaterialApp(BuildContext context, AuthProvider authProvider) {
    final initialRoute = _getInitialScreen(authProvider);
    return MaterialApp(
      title: 'The Beattie-Chanel Group',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: initialRoute,
      routes: routes,
    );
  }

  String _getInitialScreen(AuthProvider authProvider) {
    if (authProvider.isAuthenticated) {
      print('User is authenticated: ${authProvider.user!.role}');
      return authProvider.user!.role == 'agent'
          ? AgentHomeScreen.routeName
          : ClientHomeScreen.routeName;
    } else {
      print('User is not authenticated');
      return WelcomeScreen.routeName;
    }
  }
}
