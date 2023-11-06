part of 'analitics_bloc.dart';

sealed class AnaliticsState extends Equatable {
  const AnaliticsState();
  
  @override
  List<Object?> get props => [];
}

final class AnaliticsLoading extends AnaliticsState {}

final class AnaliticsError extends AnaliticsState {
  final Object? error;

  const AnaliticsError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}

final class AnaliticsLoaded extends AnaliticsState {
  final List<AnaliticData>? analiticsData;
  final AnaliticsAgregateSum? agregateSum;
  final List<AnaliticsPeriodData>? analiticsPeriodData;

  const AnaliticsLoaded({
    this.analiticsData,
    this.agregateSum,
    this.analiticsPeriodData
  });

  @override
  List<Object?> get props => [analiticsData, agregateSum, analiticsPeriodData];  
}
