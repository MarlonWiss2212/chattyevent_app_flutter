import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

class LocalizationUtils {
  static String systemLocale = "";
  static Future<void> init() async {
    systemLocale = await findSystemLocale();

    // date and time format
    await initializeDateFormatting();
    Intl.systemLocale = systemLocale;
  }
}
