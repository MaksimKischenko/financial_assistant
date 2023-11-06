import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';


import 'widgets.dart';

class PeriodPicker extends StatefulWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final Function()? onTap;

  const PeriodPicker({
    required this.fromController, 
    required this.toController,
    this.onTap
  });

  @override
  _PeriodPickerState createState() => _PeriodPickerState();
}

class _PeriodPickerState extends State<PeriodPicker> {
  DateTime get dateFrom => widget.fromController.text.toDateFormatted();
  DateTime get dateTo => widget.toController.text.toDateFormatted();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        DateField(
          prefix: 'c',
          controller: widget.fromController,
          lastDate: dateTo,
          validator: (value) {
            if (dateFrom.isAfter(dateTo)) {
              return 'Неправильный период времени';
            }
            return null;
          },
          onPicked: () {
            setState(() {
              widget.onTap?.call();
            });
          },
        ),
        const SizedBox(width: 4),
        DateField(
          prefix: 'по',
          controller: widget.toController,
          firstDate: dateFrom,
          validator: (value) {
            if (dateTo.isBefore(dateFrom)) {
              return 'Неправильный период времени';
            }
            return null;
          },
          onPicked: () {
            setState(() {
              widget.onTap?.call();
            });
          },
        ),
      ],
    ),
  );
}
