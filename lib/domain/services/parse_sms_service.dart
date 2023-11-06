
import 'package:financial_assistant/domain/domain.dart';

class ParseSmsService {
  ParseSmsService._();
  static final _instance = ParseSmsService._();
  static ParseSmsService get instance => _instance; 
  Terminal? terminal;

  SmsBody parseSmsBody(String body, {required bool makeAssociations}) {
    final amount = RegExp(r'\d+\.\d').stringMatch(body);

    var date = '';
    final dateRegex = RegExp(r'(\d{2}\.\d{2}\.\d{4} \d{2}:\d{2}:\d{2})');
    final dateMatch = dateRegex.firstMatch(body);
    if (dateMatch != null) {
       date = dateMatch.group(1) ?? '';
    }

    final currencyParts = body.split(' ');
    var currency = '';
    for (final part in currencyParts) {
      if (part.contains('USD')) {
        currency = 'USD';
      } else if (part.contains('BYN')) {
        currency = 'BYN';
      }
    }

    final terminalParts = body.split(';');
    var remoteName = '';

    if(terminalParts[0].contains(ActionCategories.paymentOffLine.actionName) 
    || terminalParts[0].contains(ActionCategories.paymentOnLine.actionName)) {
      remoteName = terminalParts[1].split('>')[0];
      if(makeAssociations) {
        terminal = Terminal(
          associatedName: terminalAssociations(terminalName: remoteName), 
          isAssociated: true,
          remoteName: remoteName
        );
      } else {
        terminal = Terminal(remoteName: remoteName);
      }
    } else {
      remoteName = 'Без терминала';
      terminal = Terminal(remoteName: remoteName);
    }

    var actionCategories = ActionCategories.unknown;
    for (final element in ActionCategories.values) {
      if(terminalParts[0].contains(element.actionName)) {
        actionCategories = element;
      }
    }
  
    return SmsBody(
      paymentSumm: double.tryParse(amount ?? '') ?? 0, 
      paymentCurrency: currency, 
      paymentDate: date,
      actionCategory: actionCategories,
      terminal: terminal
    );
  }

  String terminalAssociations({required String terminalName}) {
    if(terminalName.toLowerCase().contains('gippo')) {
      terminalName = 'GIPPO';
      
    } else if(terminalName.toLowerCase().contains('santa')){
      // ignore: parameter_assignments
      terminalName = 'SANTA';
    } else if(terminalName.toLowerCase().contains('uber') 
      || terminalName.toLowerCase().contains('yandex go')){
      // ignore: parameter_assignments
      terminalName = 'TAXI';
    } else if(terminalName.toLowerCase().contains('evroopt')){
      // ignore: parameter_assignments
      terminalName =  'EVROOPT';
    } else if(terminalName.toLowerCase().contains('zorina')){
      // ignore: parameter_assignments
      terminalName =  'ZORINA';
    } else if(terminalName.toLowerCase().contains('apteka')){
      // ignore: parameter_assignments
      terminalName =  'APTEKA';
    } else {
      // ignore: parameter_assignments
      terminalName =  'ДРУГОЕ';
    } 
    return terminalName;
  }
}