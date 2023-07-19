import 'package:path_provider/path_provider.dart';

class DirectoryUtils {
  static Future<String> getTemporaryPath() async {
    return (await getTemporaryDirectory()).path;
  }
}
