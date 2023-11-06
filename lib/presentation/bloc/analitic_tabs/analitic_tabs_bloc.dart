import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_assistant/domain/domain.dart';



part 'analitic_tabs_event.dart';
part 'analitic_tabs_state.dart';

class AnaliticsTabBloc extends Bloc<AnaliticsTabEvent, AnaliticsTabState> {
  AnaliticsTab currentTab = AnaliticsTab.services;

  AnaliticsTabBloc(): super(
    const AnaliticsTabState(
      tab: AnaliticsTab.services
    )) {
    on<AnaliticsTabEvent>(_onEvent);
  }

  Future<void> _onEvent(
    AnaliticsTabEvent event,
    Emitter<AnaliticsTabState> emit,
  ) async{
    if (event is AnaliticsTabUpdate) return _onMenuTabUpdate(event, emit);
  }

  Future<void> _onMenuTabUpdate(
    AnaliticsTabUpdate event,
    Emitter<AnaliticsTabState> emit,
  ) async {
    currentTab = event.tab;
    emit(state.copyWith(
      tab: event.tab,
    ));
  }
}
