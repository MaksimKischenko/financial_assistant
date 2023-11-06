part of 'app_manager_bloc.dart';

sealed class AppManagerState extends Equatable {
  const AppManagerState();
  
  @override
  List<Object> get props => [];
}

final class AppManagerLoading extends AppManagerState {}

final class AppManagerCurrentState extends AppManagerState {
  final bool isFirstLoad;

  const AppManagerCurrentState({
    required this.isFirstLoad
  });

  @override
  List<Object> get props => [isFirstLoad];
}
