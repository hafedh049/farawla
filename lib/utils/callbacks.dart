import 'package:farawla/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> load() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  boxes.clear();
  for (final file in (await getApplicationDocumentsDirectory()).listSync()) {
    String entity = file.path.substring(file.path.lastIndexOf("\\") + 1);
    if (entity.endsWith(".hive")) {
      boxes.add(await Hive.openBox(entity.replaceAll(".hive", "")));
    }
  }
  return true;
}

void showSnack(String msg, BuildContext context) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'On Snap!',
      message: 'This is an example error message that will be shown in the body of snackbar!',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
