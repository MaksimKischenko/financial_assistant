import 'package:financial_assistant/data/data.dart';
import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/bloc.dart';


class AppWrapper extends StatefulWidget {
  final Widget child;

  const AppWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final _dataManager = DataManager.instance;  
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<AppManagerBloc>(
        create: (context) => AppManagerBloc()..add(AppManagerRun()),
      ),
      BlocProvider<SmsBloc>(
        create: (context) => SmsBloc()
        ..add(SmsAllStatistics())
        ..add(SmsListen()),
      ),
      BlocProvider<AnaliticsBloc>(
        create: (context) => AnaliticsBloc()
        ..add(
          AnaliticsBySubjects(
            from: _dataManager.initialDateFrom.toDateFormatted(),
            to: _dataManager.initialDateTo.toDateFormatted(),
            subject: AnaLiticSubject.byServices
          ))             
      ),
      BlocProvider<AnaliticsTabBloc>(
        create: (context) => AnaliticsTabBloc(),
      ),                   
      BlocProvider<MenuBloc>(
        create: (context) => MenuBloc(),
      ),                        
    ],
    child: widget.child
  );
}
