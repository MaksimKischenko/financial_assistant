import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FiltersButton extends StatelessWidget {
  final Function() onTap;

  const FiltersButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => IconButton(
    icon: SvgPicture.asset(
      'assets/icons/filters.svg'
    ),
    onPressed: onTap
  );
}