part of 'analitics_bloc.dart';

sealed class AnaliticsEvent extends Equatable {
  const AnaliticsEvent();

  @override
  List<Object> get props => [];
}

final class AnaliticsBySubjects extends AnaliticsEvent{
  final DateTime from;
  final DateTime to;
  final AnaLiticSubject subject;

  const AnaliticsBySubjects({
    required this.from,
    required this.to,
    required this.subject
  });

  @override
  List<Object> get props => [from, to, subject];  
}

