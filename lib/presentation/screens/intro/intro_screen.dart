import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();



  @override
  Widget build(BuildContext context) => Scaffold(
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Theme.of(context).colorScheme.background,
        // allowImplicitScrolling: true,
        // autoScrollDuration: 3000,
        // infiniteAutoScroll: true,
        pages: [
          PageViewModel(
            title: 'Получение SMS-рассылки',
            body: 'Приложение будет получать SMS-рассылку от BNB-банка',
            image: SvgPicture.asset(
              SvgRepo.smsSearch.location,
              width: 120,
              height: 120,
            ), 
            decoration: PageDecoration(
              titleTextStyle: Theme.of(context).textTheme.titleMedium ?? const TextStyle(),
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
            ),
          ),
          PageViewModel(
            title: 'Анализ платежей',
            body: 'Далее приложение проанализирует все денежные операции с карт BNB-банка',
            image: SvgPicture.asset(
              SvgRepo.payCard.location,
              width: 120,
              height: 120,
            ), 
            decoration: PageDecoration(
              titleTextStyle: Theme.of(context).textTheme.titleMedium ?? const TextStyle(),
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
            ),
          ), 
          PageViewModel(
            title: 'Получение отчета',
            body: 'Вы сможете получить суммарный отчет по операциям за выбранный период времени',
            image: SvgPicture.asset(
              SvgRepo.report.location,
              width: 120,
              height: 120,
            ), 
            decoration: PageDecoration(
              titleTextStyle: Theme.of(context).textTheme.titleMedium ?? const TextStyle(),
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
            ),
          ),
          PageViewModel(
            title: 'Детализация по платежам',
            body: 'Приложение детализирует операции по безналичным платежам',
            image: SvgPicture.asset(
              SvgRepo.payments.location,
              width: 120,
              height: 120,
            ), 
            decoration: PageDecoration(
              titleTextStyle: Theme.of(context).textTheme.titleMedium ?? const TextStyle(),
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
            ),
          ),                                            
        ],
        onDone: _onIntroEnd,
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        skip: const Text('Пропустить', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Начать', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        dotsDecorator: DotsDecorator(
          size: const Size(10, 10),
          color: Theme.of(context).colorScheme.background,
          activeSize: const Size(22, 10),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),                       
      ),
    );

   void _onIntroEnd() {
    context.read<AppManagerBloc>().add(AppManagerSubmitIntro());
    context.go('/home');
  }  
}