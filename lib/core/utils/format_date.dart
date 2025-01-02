import 'package:intl/intl.dart';

class FormatDate {
  final DateTime date;

  FormatDate({required this.date});

  String dateBydMMMYYYY() {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
