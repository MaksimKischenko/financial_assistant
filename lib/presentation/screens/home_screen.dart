import 'package:financial_assistant/data/data.dart';
import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:financial_assistant/presentation/screens/screens.dart';
import 'package:financial_assistant/presentation/styles.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final _dataManager = DataManager.instance;
  static const Map<MenuTab, Widget> _screensTabs = {
    MenuTab.smsBody: SmsListScreen(),
    MenuTab.analitics: AnaliticsScreen(),
    MenuTab.settings: SizedBox.shrink(),
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<SmsBloc, SmsState>(
        listener: (context, state) {
          if(state is SmsUpdate) {
            if(state.isNewSms) {
              _smsAllStatisticsRun();
              _analiticsBySubjectsRun();  
            }
          }          
        },
        child: BlocConsumer<MenuBloc, MenuState>(
            listener: (context, state) {
              _isVisible = state.isVisible;
              if (_isVisible) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            builder: (context, state) => Scaffold(
              body: IndexedStack(
                index: _screensTabs.keys.toList().indexWhere((e) => e == state.tab),
                children: _screensTabs.values.toList(),
              ), //screensTabs[state.tab],
              bottomNavigationBar: SlideTransition(
                position: _offsetAnimation,
                child: BottomNavigationBar(
                  enableFeedback: true,
                  items: [
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        SvgRepo.transaction.location,
                        width: 24,
                        height: 24,
                      ),
                      icon: SvgPicture.asset(
                        SvgRepo.transactionDis.location,
                        width: 24,
                        height: 24,
                      ),
                      label: 'Транзакции',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        SvgRepo.analitics.location,
                        width: 24,
                        height: 24,
                      ),
                      icon: SvgPicture.asset(
                        SvgRepo.analiticsDis.location,
                        width: 24,
                        height: 24,
                      ),
                      label: 'Аналитика',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        SvgRepo.settings.location,
                        width: 24,
                        height: 24,
                      ),
                      icon: SvgPicture.asset(
                        SvgRepo.settingsDis.location,
                        width: 24,
                        height: 24,
                      ),
                      label: 'Настройки',
                    ),
                  ],
                  currentIndex: _screensTabs.keys.toList().indexOf(state.tab),
                  selectedItemColor: AppStyles.mainColor,
                  onTap: _onItemTapped,
                ),
              ),
            )),
      );

  void _onItemTapped(int index) {
    context.read<MenuBloc>().add(MenuTabUpdate(tab: _screensTabs.keys.toList()[index]));
  }

  void _smsAllStatisticsRun() {
    context.read<SmsBloc>().add(SmsAllStatistics());
  }

  void _analiticsBySubjectsRun() {
    context.read<AnaliticsBloc>().add(AnaliticsBySubjects(
      from: _dataManager.initialDateFrom.toDateFormatted(),
      to: _dataManager.initialDateTo.toDateFormatted(),
      subject: AnaLiticSubject.byServices
    ));      
  }
}
