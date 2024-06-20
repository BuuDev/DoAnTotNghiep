import 'package:intl/intl.dart';

class Helper {
  static String toMoney(String val) {
    var f = NumberFormat("###,###,###,###");
    return f.format(double.parse(val));
  }

  static int daysBetween(from, to) {
    from = DateTime.parse(from);
    to = DateTime.parse(to);
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String formatDate(value) {
    return DateFormat('dd/ MM/ yyyy').format(DateTime.parse(value));
  }
}
