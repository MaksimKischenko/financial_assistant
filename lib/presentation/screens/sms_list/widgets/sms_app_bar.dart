
import 'package:financial_assistant/presentation/scrollable_screen_routes.dart';
import 'package:financial_assistant/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SmsListAppBar extends SliverPersistentHeaderDelegate {
  final String title;

  const SmsListAppBar({
    required this.title,
  });

  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          FiltersButton(
            onTap: () {
              ScrollableRoutes.toSmsFilter(context: context);
            },
          )
        ],
        title: Text(
          title,
          style: Theme.of(context).appBarTheme.titleTextStyle
        ),   
      ),
    );

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
