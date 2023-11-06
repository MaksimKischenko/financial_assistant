import 'dart:isolate';

import 'package:flutter/services.dart';

class IsolateData {
  final RootIsolateToken token;
  final Function() function;
  final SendPort answerPort;

  IsolateData({
    required this.token,
    required this.function,
    required this.answerPort,
  });
}

