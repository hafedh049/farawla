import 'package:farawla/farawla_container.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < 20; i += 1) ...<Widget>[
                const FarawlaContainer(),
                const SizedBox(height: 30),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
