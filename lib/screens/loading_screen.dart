import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/services.dart';
import 'package:chat_app/screens/screens.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('LoadingScreen'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticated = await authService.isLoggedIn();
    if (authenticated) {
      Future.microtask(
        () => {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsersScreen(),
              transitionDuration: const Duration(milliseconds: 0),
            ),
          )
        },
      );
    } else {
      Future.microtask(
        () => {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: const Duration(milliseconds: 0),
            ),
          )
        },
      );
    }
  }
}
