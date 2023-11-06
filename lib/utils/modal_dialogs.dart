import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


mixin ModalDialogs { 
  static bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
  static const TextTheme iosTextTheme = Typography.blackCupertino;

  static Future<DateTime?> showdatePicker(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime firstDate,
      required DateTime lastDate}) {
    if (isIOS) {
      final normalHeight = MediaQuery.of(context).copyWith().size.height / 4;
      const maxHeight = 180.0;
      return showModalBottomSheet<DateTime>(
          backgroundColor: const Color(0xffd1d1d1), //.withOpacity(0.9),
          context: context,
          builder: (context) {
            var selected = initialDate;
            return Theme(
              data: Theme.of(context).copyWith(textTheme: iosTextTheme),
              child: SafeArea(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      color: const Color(0xffffffff).withOpacity(0.5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Закрыть',
                              style: TextStyle(
                                  color: CupertinoColors.systemRed,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, selected),
                            child: const Text(
                              'Готово',
                              style: TextStyle(
                                  color: CupertinoColors.systemBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    // height: 180,
                    height: normalHeight > maxHeight ? maxHeight : normalHeight,
                    child: CupertinoDatePicker(
                        onDateTimeChanged: (selectedDate) {
                          selected = selectedDate;
                        },
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: initialDate,
                        minimumDate: firstDate,
                        maximumDate: lastDate),
                  )
                ],
              )),
            );
          });
    } else {
      return showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate
      );
    }
  }  

  static Future<T?> showScrollableDialog<T>({
    required BuildContext context,
    required Widget Function(
    BuildContext context)
    builder,
    double topCornerRadius = 24
  }) {{
      final topOffset = MediaQuery.of(context).padding.top +
          MediaQuery.of(context).copyWith().size.height * 0.5;
      return showModalBottomSheet<T>(
        context: context,
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), 
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // padding: MediaQuery.of(context).viewInsets,
            height: MediaQuery.of(context).copyWith().size.height - topOffset,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(topCornerRadius),
              child: Material(
                // child: builder(context, null),
                child: builder(context),
              ),
            ),
          ),
        ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(topCornerRadius))),
        backgroundColor: const Color(0xffFCFCFC),
      );
    }
  }
}


