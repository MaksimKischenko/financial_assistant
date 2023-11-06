part of 'analitic_tabs_bloc.dart';

class AnaliticsTabState extends Equatable {
  final AnaliticsTab tab;

  const AnaliticsTabState({
    required this.tab
  });

  @override
  List<Object> get props => [tab];
  
  AnaliticsTabState copyWith({
    AnaliticsTab? tab,
  }) => AnaliticsTabState(
    tab: tab ?? this.tab,
  );
}