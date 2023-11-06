import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_assistant/domain/domain.dart';


part 'sms_event.dart';
part 'sms_state.dart';


class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final ParseSmsService parseSmsService;
  final GetSmsService getService;
  SmsBloc() :
   getService = GetSmsService.instance,
   parseSmsService = ParseSmsService.instance,
   super(SmsLoading()) {
    on<SmsEvent>(_onEvent, transformer: concurrent());
  }

  List<SmsBody?> smsBodies = [];

  Future<void> _onEvent(
    SmsEvent event,
    Emitter<SmsState> emit,
  ) async {
    if (event is SmsListen) return _onSmsListen(event, emit);
    if (event is SmsAllStatistics) return _onAllStatRun(event, emit);
    if (event is SmsFilterStatistics) return _onFilterStatRun(event, emit);
  }

  Future<void> _onSmsListen(
    SmsListen event,
    Emitter<SmsState> emit
  ) async { 
     await emit.forEach<bool>(
      getService.myStream, 
      onData: (isNewSms) => SmsUpdate(
        isNewSms: isNewSms
      )
    );   
  }

  Future<void> _onAllStatRun(
    SmsAllStatistics event,
    Emitter<SmsState> emit
  ) async { 

    emit(SmsLoading());

    final result = await getService.getAllSmsStatistics();
    result.fold(
      (failure) => emit(SmsError(error: failure)), 
      (right) {

      smsBodies = right.map((e) => parseSmsService.parseSmsBody(
        e.body ?? '',
        makeAssociations: false
      ))
      .where((element) => element.actionCategory != ActionCategories.unknown).toList();

      log('${smsBodies.map((e) => e?.terminal?.remoteName)}');

      emit(SmsFullLoaded(
        smsBodies: smsBodies.toList()
      )); 
      }
    );
  }

  Future<void> _onFilterStatRun(
    SmsFilterStatistics event,
    Emitter<SmsState> emit
  ) async { 
    emit(SmsLoading());

    final result = await getService.getSMSByFilters(
      selectedDateFrom: event.from,
      selectedDateTo: event.to
    );

    result.fold(
      (failure) => emit(SmsError(error: failure)), 
      (right) {

      smsBodies = right.map((e) => parseSmsService.parseSmsBody(
        e.body ?? '', makeAssociations: false
      ))
      .where((element) => element.actionCategory == event.category).toList();

      emit(SmsFullLoaded(
        smsBodies: smsBodies.toList()
      )); 
      }
    );
  }  
}
