import 'package:flutter/material.dart';
import 'package:the_beattie_chanel_group/screens/agent_home/agent_home_screen.dart';

import 'screens/client_home/client_home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/welcome/welcome_screen.dart';



final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ClientHomeScreen.routeName: (context) => const ClientHomeScreen(),
  AgentHomeScreen.routeName: (context) => const AgentHomeScreen(),
};
