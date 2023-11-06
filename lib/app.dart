import 'package:financial_assistant/app_state_manager.dart';
import 'package:financial_assistant/presentation/routes.dart';
import 'package:financial_assistant/presentation/themes.dart';
import 'package:flutter/material.dart';



class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppStateManager _appStateManager;  

  @override
    void initState() {
    super.initState();
    _appStateManager = AppStateManager(context: context);
    WidgetsBinding.instance.addObserver(_appStateManager);
  }  
    
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateManager);
    super.dispose();
  }  
  
  @override
  Widget build(BuildContext context) => MaterialApp.router(
      routerConfig: router, 
      theme: AppThemes.ligthTheme
    );
}
