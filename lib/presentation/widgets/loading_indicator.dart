import 'package:financial_assistant/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoadingIndicator extends StatelessWidget {
  final Color color;
  final double indicatorsSize;
  
  const LoadingIndicator({
    Key? key,
    this.color = Colors.transparent,
    this.indicatorsSize = 24
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LoadingAnimationWidget.discreteCircle(
    color: AppStyles.mainColor,
    secondRingColor: AppStyles.secondaryColor,
    thirdRingColor: AppStyles.disableColor,
    size: indicatorsSize
  );
}