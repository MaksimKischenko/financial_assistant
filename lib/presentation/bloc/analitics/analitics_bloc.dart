import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_assistant/domain/domain.dart';

part 'analitics_event.dart';
part 'analitics_state.dart';

class AnaliticsBloc extends Bloc<AnaliticsEvent, AnaliticsState> {
  final ParseSmsService parseSmsService;
  final GetSmsService getService;
  final AnaliticsService analiticsService;
  AnaliticsBloc() : 
    parseSmsService = ParseSmsService.instance,
    getService = GetSmsService.instance,
    analiticsService = AnaliticsService.instance,
    super(AnaliticsLoading()) {
      on<AnaliticsEvent>(_onEvent);
    }

  Future<void> _onEvent(
    AnaliticsEvent event,
    Emitter<AnaliticsState> emit,
  ) async {
    if (event is AnaliticsBySubjects) return _onServicesRun(event, emit);
  }


  Future<void> _onServicesRun(
    AnaliticsBySubjects event,
    Emitter<AnaliticsState> emit
  ) async { 
    emit(AnaliticsLoading());

    final result = await getService.getSMSByFilters(
      selectedDateFrom: event.from,
      selectedDateTo: event.to
    );

    result.fold(
      (failure) => emit(AnaliticsError(error: failure)), 
      (right) async{
        final smsBodies = right.map((e) => parseSmsService.parseSmsBody(
          e.body ?? '',
          makeAssociations: true
        )).where((element) => element.actionCategory != ActionCategories.unknown).toList();
        
        if(event.subject == AnaLiticSubject.bySumPeriod) {
          final data =  analiticsService.makeSummPeriodAnalitics(smsBodies);

          emit(AnaliticsLoaded(
            analiticsPeriodData: data
          ));  
        } else {
          final(analiticsData, agregateSum) = analiticsService.makeAnalitics(smsBodies, event.subject);
          emit(AnaliticsLoaded(
            analiticsData: analiticsData,
            agregateSum: agregateSum
          ));         
        }
      }
    );
  } 
}

class User {
  final int age;

  const User({
    required this.age,
  });
}
