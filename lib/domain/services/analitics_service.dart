

import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/utils/date_helper.dart';

class AnaliticsService {
  AnaliticsService._();
  static final _instance = AnaliticsService._();
  static AnaliticsService get instance => _instance; 
  
  (List<AnaliticData>, AnaliticsAgregateSum) makeAnalitics(List<SmsBody> bodies, AnaLiticSubject subject) {
    switch (subject) {
      case AnaLiticSubject.byServices:

        final terminalSummaries = bodies.fold<Map<String, double>>({}, (Map<String, double> summaries, sms) {
            if(sms.terminal?.associatedName != null) {
              summaries[sms.terminal?.associatedName ?? ''] = (summaries[sms.terminal?.associatedName ?? ''] ?? 0.0) + (sms.paymentSumm);
            }
            return summaries;
          });
          final analiticsList = terminalSummaries.map((key, value) => MapEntry(
            key, 
            AnaliticData(
              analiticSubjectKey: key, 
              value: value
            )
          )).values.toList();
        final agregateSum = AnaliticsAgregateSum(agregateOutSum: analiticsList.map((e) => e.value).fold<double>(0, (previousValue, element) => previousValue + element));
        return (analiticsList, agregateSum);
      case AnaLiticSubject.byActionCategory:
        final actionSummaries = bodies.fold<Map<String, double>>({}, (Map<String, double> summaries, sms) {
            summaries[sms.actionCategory.actionName] = (summaries[sms.actionCategory.actionName] ?? 0.0) + (sms.paymentSumm);
            return summaries;
          });
          final analiticsList = actionSummaries.map((key, value) => MapEntry(
            key, 
            AnaliticData(
              analiticSubjectKey: key, 
              value: value
            )
          )).values.toList();

        final agregateOutSum = analiticsList.
        where((element) => element.analiticSubjectKey != ActionCategories.transfer.actionName
        && element.analiticSubjectKey != ActionCategories.transferFrom.actionName
        ).
        map((e) => e.value).
        fold<double>(0, (previousValue, element) => previousValue + element);   

        final agregateInSum = analiticsList.
        where((element) => element.analiticSubjectKey == ActionCategories.transfer.actionName
        ||element.analiticSubjectKey == ActionCategories.transferFrom.actionName
        ).
        map((e) => e.value).
        fold<double>(0, (previousValue, element) => previousValue + element);     

        return (analiticsList, AnaliticsAgregateSum(
          agregateOutSum: agregateOutSum,
          agregateInSum: agregateInSum
        ));
      default:
        return ([], const AnaliticsAgregateSum());
    }
  }


  List<AnaliticsPeriodData> makeSummPeriodAnalitics(List<SmsBody> bodies) {
      final currentDate = DateTime.now();
      final startDate = DateTime(currentDate.year, 1, 1);
      final monthLists = <int, List<SmsBody>>{};

      for (var i = startDate.month; i <= currentDate.month; i++) {
        monthLists[i] = [];
      }

      for (final body in bodies) {
        if (body.paymentDate.toDateFormatted().isAfter(startDate) 
            && body.paymentDate.toDateFormatted().isBefore(currentDate)
          ) {
          monthLists[body.paymentDate.toDateFormatted().month]?.add(body);
        }
      }

      final result = monthLists.map((key, value) => 
        MapEntry(
          key, 
          AnaliticsPeriodData(
            monthX: key,
            y1: value.where((element) => element.terminal?.associatedName == 'GIPPO').map((e) => e.paymentSumm).fold(0, (previousValue, element) => previousValue + element),
            y2: value.where((element) => element.terminal?.associatedName == 'SANTA').map((e) => e.paymentSumm).fold(0, (previousValue, element) => previousValue + element),
            y3: value.where((element) => element.terminal?.associatedName == 'TAXI').map((e) => e.paymentSumm).fold(0, (previousValue, element) => previousValue + element),
            y4: value.where((element) => element.terminal?.associatedName == 'EVROOPT').map((e) => e.paymentSumm).fold(0, (previousValue, element) => previousValue + element),
            y5: value.where((element) => element.terminal?.associatedName == 'ZORINA').map((e) => e.paymentSumm).fold(0, (previousValue, element) => previousValue + element),
            y6: value.where((element) => element.terminal?.associatedName == 'APTEKA').map((e) => e.paymentSumm).fold(0, (previousValue, element) => previousValue + element),
            y7: value.where((element) => element.terminal?.associatedName == 'ДРУГОЕ').map((e) => e.paymentSumm).fold(0, (previousValue, element) => previousValue + element),          
          )
        )
      ).values.toList();
    return result;     
  }
}