import 'package:financial_assistant/domain/domain.dart';
import 'package:financial_assistant/presentation/bloc/bloc.dart';
import 'package:financial_assistant/presentation/bloc/sms/sms_bloc.dart';
import 'package:financial_assistant/presentation/widgets/widgets.dart';
import 'package:financial_assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class SmsFilterScreen extends StatefulWidget {
  @override
  State<SmsFilterScreen> createState() => _SmsFilterScreenState();
}

class _SmsFilterScreenState extends State<SmsFilterScreen> {
  late GlobalKey _dateFormKey; 
  late TextEditingController _fromController;
  late TextEditingController _toController;
  String get initialDateFrom => DateTime.now().subtract(Duration(days: DateTime.now().day -1)).toStringFormatted();
  String get initialDateTo => DateTime.now().add(const Duration(days: 1)).toStringFormatted();
  final categories =  ActionCategories.values.where((element) => element != ActionCategories.unknown).toList();
  ActionCategories selectedCategory = ActionCategories.unknown;

  @override
  void initState() {
    super.initState();
    _dateFormKey = GlobalKey<FormState>(); 
    _fromController = TextEditingController();
    _toController = TextEditingController();
    _fromController.text = initialDateFrom;
    _toController.text = initialDateTo;    
  }

  @override
    void dispose() {
      _fromController.dispose();
      _toController.dispose();
      super.dispose();
    }  

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: Form(
          key: _dateFormKey,
          child: PeriodPicker(
          fromController: _fromController,
          toController: _toController,
          ),
        ),
      ),  
      Wrap(
        runSpacing: 12,
        spacing: 24,
        children: categories.mapIndexed(
          (e, index) => Padding(
            padding: const EdgeInsets.all(1),
            child: ElevatedButton(
              onPressed: () {
                selectFilter(index);
              }, 
              child: Text(categories[index].actionName)
            )
          )
        ).toList()
      ),              
    ],
  );

  void selectFilter(int index) {
    selectedCategory = categories[index];
    context.read<SmsBloc>().add(SmsFilterStatistics(
      from: _fromController.text.toDateFormatted(), 
      to: _toController.text.toDateFormatted(), 
      category: selectedCategory
    ));
    context.pop();
  }
}