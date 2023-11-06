import 'package:financial_assistant/data/data.dart';
import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:financial_assistant/presentation/screens/analitics/widgets/widgets.dart';
import 'package:financial_assistant/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaliticsScreen extends StatefulWidget {
  const AnaliticsScreen({super.key});

  @override
  State<AnaliticsScreen> createState() => _AnaliticsScreenState();
}

class _AnaliticsScreenState extends State<AnaliticsScreen> with SingleTickerProviderStateMixin {
  late ScrollController _hideBottomNavController;
  late TabController _tabController;
  late GlobalKey _dateFormKey;
  late TextEditingController _fromController;
  late TextEditingController _toController;
  final _dataManager = DataManager.instance;
  var _isVisible = true;

  final List<Tab> _tabs = AnaLiticSubject.values.map<Tab>((e) => Tab(text: e.actionName)).toList();

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    _hideBottomNavController.dispose();
    _tabController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<AnaliticsBloc, AnaliticsState>(
      builder: (context, state) {
        if (state is AnaliticsLoaded) {
          return CustomScrollView(
            controller: _hideBottomNavController,
            shrinkWrap: true,
            slivers: [
              const SliverPersistentHeader(
                delegate: AnaliticsAppBar(
                  title: 'Аналитика',
                ),
                floating: true,
                pinned: true,
              ),
              AnaliticsTabs(
                agregateSum: state.agregateSum,
                tabController: _tabController,
                tabs: _tabs,
                analiticsData: state.analiticsData,
                analiticPeriodsData: state.analiticsPeriodData,
                dateFormKey: _dateFormKey,
                fromController: _fromController,
                toController: _toController,
              )
            ],
          );
        } else if (state is AnaliticsLoading) {
          return const Center(
            child: LoadingIndicator(),
          );
        } else {
          return const SizedBox.expand();
        }
      },
    ),
  );


  void initControllers() {
    _dateFormKey = GlobalKey<FormState>();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    _fromController.text = _dataManager.initialDateFrom;
    _toController.text = _dataManager.initialDateTo;
    _tabController = TabController(length: _tabs.length, vsync: this);
    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(() {
      if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) {
          _isVisible = false;
          context.read<MenuBloc>().add(MenuHide());
        }
        ;
      } else if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_isVisible) {
          _isVisible = true;
          context.read<MenuBloc>().add(MenuShow());
        }
      }
    });
  }
}
