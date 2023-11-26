import 'package:farawla/farawels.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(title: "Farawla", debugShowCheckedModeBanner: false, home: const Farawels(), theme: ThemeData.light());
}
