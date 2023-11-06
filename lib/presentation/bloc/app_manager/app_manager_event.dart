part of 'app_manager_bloc.dart';

sealed class AppManagerEvent extends Equatable {
  const AppManagerEvent();

  @override
  List<Object> get props => [];
}
final class AppManagerSubmitIntro extends AppManagerEvent {}
final class AppManagerRun extends AppManagerEvent {}
