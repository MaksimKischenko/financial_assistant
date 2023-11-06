// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financial_assistant/domain/domain.dart';

class SmsBody {
  final double paymentSumm;
  final String paymentCurrency;
  final String paymentDate;
  final ActionCategories actionCategory;
  final Terminal? terminal;

  const SmsBody({
    this.terminal,
    required this.paymentSumm,
    required this.paymentCurrency,
    required this.paymentDate,
    required this.actionCategory,
  });

  factory SmsBody.empty() => const SmsBody(
    paymentSumm: 0, 
    paymentCurrency: 'Неизвестно', 
    paymentDate: 'Неизвестно',
    actionCategory: ActionCategories.unknown
  );

  @override
  String toString() => 'paymentDate: $paymentDate)';
}
