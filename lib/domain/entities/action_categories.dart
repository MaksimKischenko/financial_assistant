import 'package:financial_assistant/presentation/styles.dart';
import 'package:flutter/material.dart';

enum ActionCategories {

  paymentOffLine('Oplata', AppStyles.mainColor),
  paymentOnLine('Oplata v internete', Colors.blueAccent), 
  available('Dostupno', Colors.green),
  transferTo('Spisan perevod', Colors.redAccent),
  moneyFromTerminal('Sniatie nalichnyh', Colors.redAccent),
  unknown('unknown', Colors.black),
  transfer('Zachisleno', Colors.amberAccent),
  transferFrom('Zachislen perevod', Colors.amberAccent);

  const ActionCategories(this.actionName, this.color);
  final String actionName;
  final Color color;
}