import 'package:farawla/farawels_container.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 20,
              spacing: 20,
              children: <Widget>[
                for (int i = 0; i < 20; i += 1) const FarawelsContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
