import 'package:farawla/utils/globals.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> load() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  for (final file in (await getApplicationDocumentsDirectory()).listSync()) {
    String entity = file.path.substring(file.path.lastIndexOf("\\") + 1);
    if (entity.endsWith(".hive")) {
      boxes.add(await Hive.openBox(entity));
    }
  }
}
