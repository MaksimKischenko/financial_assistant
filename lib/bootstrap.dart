import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:financial_assistant/app.dart';
import 'package:financial_assistant/app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/bloc_observer.dart';


Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.transformer = sequential<dynamic>();    
  Bloc.observer = SimpleBlocObserver();
  runApp(const AppWrapper(child: App()));   
}

