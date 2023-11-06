import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/styles.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';


class CategoriesBar extends StatelessWidget {
  const CategoriesBar({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) => SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (_, simpleIndex) => Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: ActionCategories.values.mapIndexed(
              (e, index) => Padding(
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          color: ActionCategories.values[index].color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          ActionCategories.values[index].actionName,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppStyles.mainTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                          ),
                        )                    
                      ],
                    ),
                  ],
                ),
              )
            ).toList()
          ),
        )
      ),
    );
}

