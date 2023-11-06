import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/screens/sms_list/widgets/widgets.dart';
import 'package:flutter/material.dart';


class SmsList extends StatelessWidget {
  final List<SmsBody?> listSmsBodies;

  const SmsList({
    Key? key,
    required this.listSmsBodies
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) => SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: listSmsBodies.length,
        (_, index) => PaymentItem(
          body: listSmsBodies[index] ?? SmsBody.empty(),
        )
      ),
    );
}
