import 'package:farawla/farawla_container.dart';
import 'package:flutter/material.dart';

class Farawels extends StatefulWidget {
  const Farawels({super.key});

  @override
  State<Farawels> createState() => _FarawelsState();
}

class _FarawelsState extends State<Farawels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48),
        child: Wrap(
          children: <Widget>[
            for (int i = 0; i < 10; i += 1) FarawlaContainer(),
          ],
        ),
      ),
    );
  }
}
