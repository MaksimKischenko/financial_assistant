import 'package:intl/intl.dart';

extension DateHelperString on String {

  DateTime toDateFormatted() {
    final dateFormat = DateFormat('dd.MM.yyyy');
    return dateFormat.parse(this);
  }

}

extension DateHelperDateTime on DateTime {

  String toStringFormatted() => DateFormat('dd.MM.yyyy').format(this);

  String toStringFormattedGetOperationHistory() => DateFormat('dd.MM.yyyy HH:mm:ss').format(this);

}