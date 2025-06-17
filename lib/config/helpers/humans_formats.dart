import 'package:intl/intl.dart';

class HumansFormats {
  static String number(double number) {
    final formatedNumber = NumberFormat.compactCurrency(
            decimalDigits: 0,
            symbol: '',
            locale: 'en'
            ).format(number);


         return formatedNumber;   
  }
}
