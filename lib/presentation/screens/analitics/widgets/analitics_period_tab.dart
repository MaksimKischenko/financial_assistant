import 'package:financial_assistant/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnaliticsPeriodTab extends StatefulWidget {
  final List<AnaliticsPeriodData> chartData;
  
  const AnaliticsPeriodTab({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  @override
  State<AnaliticsPeriodTab> createState() => _AnaliticsPeriodTabState();
}

class _AnaliticsPeriodTabState extends State<AnaliticsPeriodTab> {

 List<Color> palette = const <Color>[
    Color.fromRGBO(75, 135, 185, 1),
    Color.fromRGBO(192, 108, 132, 1), 
    Color.fromRGBO(246, 114, 128, 1), 
    Color.fromRGBO(248, 177, 149, 1),
    Color.fromRGBO(116, 180, 155, 1), 
    Color.fromRGBO(0, 168, 181, 1), 
    Color.fromRGBO(73, 76, 162, 1), 
    Color.fromRGBO(255, 205, 96, 1), 
    Color.fromRGBO(255, 240, 219, 1),
    Color.fromRGBO(238, 238, 238, 1)
  ];  

  Map<int, String> chartDataMap = {
    0: 'GIPPO',
    1: 'SANTA',
    2: 'TAXI',
    3: 'EVROOPT',
    4: 'ZORINA',
    5: 'APTEKA',
    6: 'ДРУГОЕ',                            
  };

  @override
  Widget build(BuildContext context) => Center(
    child: SfCartesianChart(
        palette: palette,
        legend: Legend(
          isVisible: true,
          width: '${MediaQuery.of(context).size.width}',
          legendItemBuilder: (legendText, series, point, seriesIndex) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: SizedBox(
                width: 80,
                child: Row(
                  children: [
                    Text(
                      chartDataMap[seriesIndex] ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Icon(
                      Icons.data_exploration_rounded, size: 16,
                      color: palette[seriesIndex],
                    ),
                  ]
                )  
              ),
            ),
        ),
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[  
            StackedColumnSeries<AnaliticsPeriodData, int>(
                dataSource: widget.chartData,
                xValueMapper: (AnaliticsPeriodData data, _) => data.monthX,
                yValueMapper: (AnaliticsPeriodData data, _) => data.y1,
            ),
            StackedColumnSeries<AnaliticsPeriodData, int>(
                dataSource: widget.chartData,
                xValueMapper: (AnaliticsPeriodData data, _) => data.monthX,
                yValueMapper: (AnaliticsPeriodData data, _) => data.y2,
            ),
              StackedColumnSeries<AnaliticsPeriodData,int>(
                dataSource: widget.chartData,
                xValueMapper: (AnaliticsPeriodData data, _) => data.monthX,
                yValueMapper: (AnaliticsPeriodData data, _) => data.y3
            ),
            StackedColumnSeries<AnaliticsPeriodData, int>(
                dataSource: widget.chartData,
                xValueMapper: (AnaliticsPeriodData data, _) => data.monthX,
                yValueMapper: (AnaliticsPeriodData data, _) => data.y4
            ),
            StackedColumnSeries<AnaliticsPeriodData, int>(
                dataSource: widget.chartData,
                xValueMapper: (AnaliticsPeriodData data, _) => data.monthX,
                yValueMapper: (AnaliticsPeriodData data, _) => data.y5
            ),
            StackedColumnSeries<AnaliticsPeriodData, int>(
                dataSource: widget.chartData,
                xValueMapper: (AnaliticsPeriodData data, _) => data.monthX,
                yValueMapper: (AnaliticsPeriodData data, _) => data.y6
            ),
            StackedColumnSeries<AnaliticsPeriodData, int>(
                dataSource: widget.chartData,
                xValueMapper: (AnaliticsPeriodData data, _) => data.monthX,
                yValueMapper: (AnaliticsPeriodData data, _) => data.y7,
            )                                                
        ]
    ),
  );
}

