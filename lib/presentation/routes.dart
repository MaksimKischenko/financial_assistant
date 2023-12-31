import 'package:financial_assistant/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/screens.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, 

  observers: [
    GoRouterObserver()
  ],
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const SplashScreen(),   
      ),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const HomeScreen(),   
      ),
    ), 
    GoRoute(
      path: '/intro',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const IntroScreen(),   
      ),
    ),         
    // GoRoute(
    //   name: 'poem',
    //   path: '/poem',
    //   pageBuilder: (context, state) {
    //     final poem = state.extra as Poem; 
    //     return CustomTransitionPage<Poem>(
    //       key: state.pageKey,
    //         transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //             FadeTransition(opacity: animation, child: child),
    //         child: PoemScreen(poem: poem)     
    //       );
    //   },      
    // ),         
  ],
);

class GoRouterObserver extends NavigatorObserver {
  // @override
  // void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   print('MyTest didPush: $route');
  // }

  // @override
  // void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   print('MyTest didPop: $route');
  // }

  // @override
  // void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   print('MyTest didRemove: $route');
  // }

  // @override
  // void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
  //   print('MyTest didReplace: $newRoute');
  // }
}