import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:financial_assistant/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<AppManagerBloc, AppManagerState>(
      listener: (context, state) {
        if(state is AppManagerCurrentState) {
          if(state.isFirstLoad) {
            context.go('/intro');
          } else {
            context.go('/home');
          }
        }
      },
      child: const Scaffold(
        body: Center(
          child: LoadingIndicator(),
        ),
      ),
    );
}
