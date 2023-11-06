// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/styles.dart';
import 'package:flutter/material.dart';


class PaymentItem extends StatelessWidget {
  final SmsBody body;

  const PaymentItem({
    Key? key,
    required this.body,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) => ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      title: Container(
        padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: body.actionCategory.color)
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                body.terminal?.remoteName ?? '',
                style: const TextStyle(
                  color: AppStyles.mainColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Дата: ${body.paymentDate}',
                style: TextStyle(
                  color: AppStyles.mainTextColor.withOpacity(0.7),
                  fontSize: 12
                ),
              )
            ],
          ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'ВАЛЮТА',
                      style: TextStyle(
                        color: AppStyles.mainTextColor.withOpacity(0.7),
                        fontSize: 11
                      ),
                    ),
                    Text(
                      // item.accNum,
                      body.paymentCurrency,
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'СУММА',
                      style: TextStyle(
                        color: AppStyles.mainTextColor.withOpacity(0.7),
                        fontSize: 11
                      ),
                    ),
                    Text(
                      '${body.paymentSumm}',
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'ОПИСАНИЕ',
                      style: TextStyle(
                        color: AppStyles.mainTextColor.withOpacity(0.7),
                        fontSize: 11
                      ),
                    ),
                    Text(
                      body.actionCategory.actionName,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
