import 'package:farawla/farawels.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(debugShowCheckedModeBanner: false, home: Farawels());
}
