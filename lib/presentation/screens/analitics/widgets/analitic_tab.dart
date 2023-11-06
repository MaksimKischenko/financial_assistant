
import 'dart:developer';

import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:financial_assistant/presentation/widgets/widgets.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnaliticTab extends StatelessWidget {
  final List<AnaliticData> analiticsData;
  final AnaliticsAgregateSum? agregateSum;
  final TextEditingController fromController;
  final TextEditingController toController;
  final GlobalKey dateFormKey;
  
  const AnaliticTab({
    Key? key,
    required this.analiticsData,
    this.agregateSum,
    required this.fromController,
    required this.toController,
    required this.dateFormKey,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/10,
              child: Form(
                key: dateFormKey,
                child: PeriodPicker(
                  fromController: fromController,
                  toController: toController,
                  onTap: () => onTabTap(context),
                ),
              ),
            ),              
            Expanded(
              child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  width: '${MediaQuery.of(context).size.width}',
                ),
                onLegendTapped: (legendTapArgs) {
                  if(legendTapArgs.pointIndex == 0) {
                    log('TAPED');
                  }
                },
                backgroundColor: Theme.of(context).colorScheme.background,
                series: <CircularSeries<AnaliticData, String>>[
                  PieSeries<AnaliticData, String>(
                    selectionBehavior: SelectionBehavior(enable: true),
                    explode: true,
                    dataSource: analiticsData,
                    xValueMapper: (AnaliticData data, index) => analiticsData[index].analiticSubjectKey,
                    yValueMapper: (AnaliticData data, index) => analiticsData[index].value,
                    dataLabelMapper: (datum, _) => '${datum.value.toStringAsFixed(1)}\n${datum.analiticSubjectKey}',
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true, 
                    )
                  )
                ]
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(agregateSum?.agregateOutSum != null) 
                Text(
                  'ПОТРАЧЕНО:${agregateSum?.agregateOutSum?.toStringAsFixed(2)} BYN',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red.shade300, fontSize: 14),
                ),
                if(agregateSum?.agregateInSum != null) 
                Text(
                  'ЗАЧИСЛЕНО:${agregateSum?.agregateInSum?.toStringAsFixed(2)} BYN',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueGrey, fontSize: 14),
                ),                    
              ],
            ),      
          ],
        )
    );

    //Общий DataPicker для двух Taбов
    void onTabTap(BuildContext context) {
      if(context.read<AnaliticsTabBloc>().currentTab == AnaliticsTab.services) {
        context.read<AnaliticsBloc>().add(AnaliticsBySubjects(
          from: fromController.text.toDateFormatted(), 
          to: toController.text.toDateFormatted(), 
          subject: AnaLiticSubject.byServices
        ));
      } else if(context.read<AnaliticsTabBloc>().currentTab == AnaliticsTab.actionCategory) {
        context.read<AnaliticsBloc>().add(AnaliticsBySubjects(
          from: fromController.text.toDateFormatted(), 
          to: toController.text.toDateFormatted(), 
          subject: AnaLiticSubject.byActionCategory
        ));
      }
    } 
}
