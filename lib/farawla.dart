import 'package:flutter/material.dart';

class Farawla extends StatefulWidget {
  const Farawla({super.key});

  @override
  State<Farawla> createState() => _FarawlaState();
}

class _FarawlaState extends State<Farawla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[for (int i = 0; i < 20; i += 1) Container()],
        ),
      ),
    );
  }
}
