import 'package:financial_assistant/presentation/styles.dart';
import 'package:flutter/material.dart';



mixin AppThemes {
  static ThemeData get darkTheme => ThemeData.dark();

  static ThemeData get ligthTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppStyles.mainColor,
      primary: AppStyles.mainColor,
      secondary: AppStyles.mainColor,
      background: AppStyles.scaffoldColor
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppStyles.mainColor,
      titleTextStyle: TextStyle(
        fontSize: 18, 
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,  
        color: Colors.black54,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,    
        color: AppStyles.mainColor,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,    
        color: Colors.black45,
        fontStyle: FontStyle.normal,
      ),            
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
         backgroundColor: MaterialStateProperty.all(AppStyles.scaffoldColor),
         elevation: MaterialStateProperty.all(3),
      )
    ),    
  );
}
