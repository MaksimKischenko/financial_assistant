part of 'sms_bloc.dart';

sealed class SmsEvent extends Equatable {
  const SmsEvent();

  @override
  List<Object> get props => [];
}

final class SmsListen extends SmsEvent {}

final class SmsAllStatistics extends SmsEvent {}

final class SmsFilterStatistics extends SmsEvent {
  final DateTime from;
  final DateTime to;
  final ActionCategories category;

  const SmsFilterStatistics({
    required this.from,
    required this.to,
    required this.category
  });

  @override
  List<Object> get props => [from, to, category];
}