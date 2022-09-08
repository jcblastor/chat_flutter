import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String titulo;
  final String subTitulo;

  const Labels({
    Key? key,
    required this.route,
    required this.titulo,
    required this.subTitulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titulo,
          style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          child: Text(
            subTitulo,
            style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
        )
      ],
    );
  }
}
