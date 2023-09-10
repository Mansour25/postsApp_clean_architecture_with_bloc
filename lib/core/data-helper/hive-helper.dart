import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static Box? myBox;

  static Future<Box> openHiveBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    return await Hive.openBox(boxName).then((value) {
      print('Open hive is success');
      return value;
    });
  }

  static Future init() async {
    myBox = await openHiveBox('local_posts');
  }

  static Future<void> putData(String key, dynamic data) async {
    print('==========   put   ==========');
    print('put ${data.toString()} in $key');
    await myBox!.put(key, data);
  }

  static getData(String key) {
    print('==========   get   ==========');
    return myBox!.get(key);
  }
}
