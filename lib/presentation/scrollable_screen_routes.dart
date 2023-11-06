import 'package:financial_assistant/presentation/screens/sms_list/widgets/widgets.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';

mixin ScrollableRoutes {
  static Future<void> toSmsFilter({
    required BuildContext context,
  }) => ModalDialogs.showScrollableDialog<void>(
    context: context,
    builder: (context) => SmsFilterScreen(),
  );
}