import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonAzul({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: authService.isLoading
            ? MaterialStateProperty.all(Colors.grey)
            : MaterialStateProperty.all(Colors.blue),
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(const StadiumBorder()),
      ),
      onPressed: () => onPressed(),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
