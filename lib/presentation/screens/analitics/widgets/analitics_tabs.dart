import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:financial_assistant/presentation/styles.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class AnaliticsTabs extends StatefulWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final GlobalKey dateFormKey;
  final List<Tab> tabs;
  final List<AnaliticData>? analiticsData;
  final List<AnaliticsPeriodData>? analiticPeriodsData;
  final AnaliticsAgregateSum? agregateSum;
  final TabController tabController;

  const AnaliticsTabs({
    Key? key,
    required this.tabs,
    required this.dateFormKey,
    required this.fromController,
    required this.toController,
    required this.tabController,
    this.agregateSum,
    this.analiticsData,
    this.analiticPeriodsData,
  }) : super(key: key);

  @override
  State<AnaliticsTabs> createState() => _AnaliticsTabsState();
}

class _AnaliticsTabsState extends State<AnaliticsTabs> {
  static late Map<AnaliticsTab, Widget> _analiticsTabs;

  @override
  void initState() {
    _analiticsTabs = {
      AnaliticsTab.services: AnaliticTab(
        analiticsData: widget.analiticsData ?? [],
        agregateSum: widget.agregateSum,
        dateFormKey: widget.dateFormKey,
        toController: widget.toController,
        fromController: widget.fromController,
      ),
      AnaliticsTab.sumPeriod: AnaliticsPeriodTab(
        chartData: widget.analiticPeriodsData ?? []
      ),
      AnaliticsTab.actionCategory: AnaliticTab(
        analiticsData: widget.analiticsData ?? [],
        agregateSum: widget.agregateSum,
        dateFormKey: widget.dateFormKey,
        toController: widget.toController,
        fromController: widget.fromController,
      ),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SliverList(
      delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (_, simpleIndex) => Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                child: BlocListener<AnaliticsTabBloc, AnaliticsTabState>(
                  listener: (context, state) {
                    widget.tabController.animateTo(state.tab.index);
                  },
                  child: TabBar(
                    controller: widget.tabController,
                    onTap: onTabTap,
                    isScrollable: true,
                    tabs: widget.tabs,
                    indicatorColor: AppStyles.mainColor,
                    indicatorWeight: 4,
                    labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppStyles.mainColor),
                    labelColor: AppStyles.mainColor,
                    overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF)),
                    unselectedLabelColor: AppStyles.mainTextColor),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: TabBarView(
                  controller: widget.tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _analiticsTabs.values.toList()),
              ),
            ]),
          )
        ),
      );

  void onTabTap(int index) {
    context.read<AnaliticsTabBloc>().add(
      AnaliticsTabUpdate(tab: _analiticsTabs.keys.toList()[index])
    );
    if (index == 0) {
      context.read<AnaliticsBloc>().add(AnaliticsBySubjects(
        from: widget.fromController.text.toDateFormatted(),
        to: widget.toController.text.toDateFormatted(),
        subject: AnaLiticSubject.byServices)
      );
    } else if (index == 1) {
      context.read<AnaliticsBloc>().add(AnaliticsBySubjects(
        from: DateTime(DateTime.now().year, 1), 
        to: DateTime.now(), subject: AnaLiticSubject.bySumPeriod)
      );
    } else if (index == 2) {
      context.read<AnaliticsBloc>().add(AnaliticsBySubjects(
        from: widget.fromController.text.toDateFormatted(),
        to: widget.toController.text.toDateFormatted(),
        subject: AnaLiticSubject.byActionCategory)
      );
    }
  }
}
