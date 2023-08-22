import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

class IntlUtils {
  static Future<void> initialize() async {
    await initializeDateFormatting();
    Intl.systemLocale = await findSystemLocale();
  }
}
