import 'package:farawla/utils/globals.dart';
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
      body: Wrap(
        children: <Widget>[
          for (int i = 0; i < 10; i += 1)
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: blue, blurRadius: 10, spreadRadius: 10),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
