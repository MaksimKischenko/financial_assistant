import 'package:financial_assistant/utils/utils.dart';

class DataManager {
  DataManager._();
  static final _instance = DataManager._();
  static DataManager get instance => _instance;

  String? userEmail;
  String initialDateFrom = DateTime.now().subtract(Duration(days: DateTime.now().day - 1)).toStringFormatted();
  String initialDateTo = DateTime.now().add(const Duration(days: 1)).toStringFormatted();
}