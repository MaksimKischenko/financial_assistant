import 'package:financial_assistant/data/data.dart';
import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/bloc.dart';

class AppStateManager extends WidgetsBindingObserver {
  final BuildContext context;

  AppStateManager({
    required this.context,
  });

  final _dataManager = DataManager.instance;


  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _updateResumedStates();
    } 
  }
  void _updateResumedStates() {
    context.read<SmsBloc>().add(SmsAllStatistics()); 
    context.read<AnaliticsTabBloc>().add(const AnaliticsTabUpdate(tab: AnaliticsTab.services));
    context.read<AnaliticsBloc>().add(AnaliticsBySubjects(
      from: _dataManager.initialDateFrom.toDateFormatted(),
      to: _dataManager.initialDateTo.toDateFormatted(),
      subject: AnaLiticSubject.byServices
    ));   
  }
}

