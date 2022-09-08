import 'package:flutter/material.dart';

import 'package:chat_app/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': (_) => const UsersScreen(),
  'loading': (_) => const LoadingScreen(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'chat': (_) => const ChatScreen(),
};
