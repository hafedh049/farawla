import 'package:farawla/utils/globals.dart';
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
