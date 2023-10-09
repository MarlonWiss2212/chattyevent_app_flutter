import 'package:path_provider/path_provider.dart';

class DirectoryUtils {
  static Future<String> getTemporaryPath() async {
    return (await getTemporaryDirectory()).path;
  }

  static Future<String> getApplicationDocumentsPath() async {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
