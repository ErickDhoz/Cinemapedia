import 'package:intl/intl.dart';

class HumanFormats {
  static number(double number, [ int decimals = 0 ]) {
    final formatterNumber =
        NumberFormat.compactCurrency(
          decimalDigits: decimals, 
          symbol: '', 
          locale: 'es')
            .format(number);
    return formatterNumber;
  }
}
