part of 'analitic_tabs_bloc.dart';

abstract class AnaliticsTabEvent extends Equatable {
  const AnaliticsTabEvent();

  @override
  List<Object?> get props => [];
}

class AnaliticsTabUpdate extends AnaliticsTabEvent {
  final AnaliticsTab tab;

  const AnaliticsTabUpdate({required this.tab});

  @override
  List<Object?> get props => [tab];
}
