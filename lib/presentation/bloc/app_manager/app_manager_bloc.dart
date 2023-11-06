import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/domain/entities/pref_keys.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  final CacheService cacheService;
  AppManagerBloc() :
   cacheService = CacheService.instance,
   super(
    const AppManagerCurrentState(
    isFirstLoad: true
  )) {
    on<AppManagerEvent>(_onEvent);
  }

  Future<void> _onEvent(
    AppManagerEvent event,
    Emitter<AppManagerState> emit,
  ) async {
    if (event is AppManagerSubmitIntro) return _onSubmit(event, emit);
    if (event is AppManagerRun) return _onRun(event, emit);
  }

  Future<void> _onSubmit(
    AppManagerSubmitIntro event,
    Emitter<AppManagerState> emit
  ) async { 
    emit(AppManagerLoading());
    await cacheService.initialise();
    await cacheService.write(PrefsKeys.loadingStateKey, true);
    emit(const AppManagerCurrentState(isFirstLoad: false));
  }

   Future<void> _onRun(
    AppManagerRun event,
    Emitter<AppManagerState> emit
  ) async { 
    emit(AppManagerLoading());
    await GetSmsService.instance.requestSmsPermissions();
    await GetSmsService.listenForIncomingSms();
    await cacheService.initialise();
    if(!await cacheService.contains(PrefsKeys.loadingStateKey)) {
      emit(const AppManagerCurrentState(isFirstLoad: true));
    } else {
      emit(const AppManagerCurrentState(isFirstLoad: false));
    }
  }
}
