import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:financial_assistant/presentation/screens/sms_list/widgets/widgets.dart';
import 'package:financial_assistant/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmsListScreen extends StatefulWidget {
  const SmsListScreen({super.key});

  @override
  State<SmsListScreen> createState() => _SmsListScreenState();
}

class _SmsListScreenState extends State<SmsListScreen> {
  late ScrollController _hideBottomNavController;
  var _isVisible = true;
  @override
  void initState() {
    super.initState();
    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(() {
      if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) {
          _isVisible = false;
          context.read<MenuBloc>().add(MenuHide());
        };
      } else if(_hideBottomNavController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_isVisible) {
          _isVisible = true;
          context.read<MenuBloc>().add(MenuShow());
        }        
      }
    });
  }

  @override
  void dispose() {
    _hideBottomNavController.dispose();
    super.dispose();
  }
    
  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<SmsBloc, SmsState>(
      builder: (context, state) {
        if(state is SmsFullLoaded) {
          return CustomScrollView(
            controller: _hideBottomNavController,
            shrinkWrap: true,
            slivers: [
              const SliverPersistentHeader(
                delegate: SmsListAppBar(
                  title: 'Транзакции'
                ),
                floating: true,
                pinned: true,
              ),
              const CategoriesBar(),
              SmsList(
                listSmsBodies: state.smsBodies,
              )
            ],
          );
        } else if (state is SmsLoading) {
          return const Center(
            child: LoadingIndicator(),
          );
        } else {
          return const SizedBox.expand();
        }
      },
    ),
  );
}
