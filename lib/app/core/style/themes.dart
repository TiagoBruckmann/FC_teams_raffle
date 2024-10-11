// imports nativos
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/style/app_colors.dart';

class Themes {
  Themes._();

  // dark colors
  static const Color _backgroundColorDark = AppColors.toryBlue;
  static const Color _primaryColorDark = AppColors.luckyPoint;
  static const Color _onPrimaryColorDark = AppColors.toryBlueVariant;
  static const Color _secondaryColorDark = AppColors.westSide;
  static const Color _onSecondaryColorDark = AppColors.ronchi;
  static const Color _tertiaryColorDark = AppColors.pigmentGreen;
  static const Color _errorColor = AppColors.cinnabar;
  static const Color _textPrimaryDark = AppColors.whiteSmoke;

  // .****************
  // Theme - Dark
  // .****************
  static const DividerThemeData _dividerThemeDataDark = DividerThemeData(
    color: _secondaryColorDark,
    indent: 10,
    endIndent: 10,
    thickness: 1,
  );

  static const TextStyle _headlineLargeTextDark = TextStyle(
    fontWeight: FontWeight.bold,
    color: _textPrimaryDark,
    fontSize: 24,
  );

  static const TextStyle _displayLargeTextDark = TextStyle(
    fontWeight: FontWeight.w600,
    color: _textPrimaryDark,
    fontSize: 18,
  );

  static const TextStyle _displayMediumTextDark = TextStyle(
    fontWeight: FontWeight.w500,
    color: _textPrimaryDark,
    fontSize: 17,
  );

  static const TextStyle _displaySmallTextDark = TextStyle(
    fontWeight: FontWeight.w700,
    color: _textPrimaryDark,
    fontSize: 16,
  );

  static const TextStyle _bodyMediumTextDark = TextStyle(
    color: _textPrimaryDark,
    fontSize: 14,
  );

  static const TextStyle _bodySmallTextDark = TextStyle(
    color: _textPrimaryDark,
    fontSize: 12,
  );

  static const TextTheme _textThemeDark = TextTheme(
    headlineLarge: _headlineLargeTextDark,
    displayLarge: _displayLargeTextDark,
    displayMedium: _displayMediumTextDark,
    displaySmall: _displaySmallTextDark,
    bodyMedium: _bodyMediumTextDark,
    bodySmall: _bodySmallTextDark,
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: "PressStart2P",
    useMaterial3: true,
    scaffoldBackgroundColor: _backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColorDark,
      centerTitle: true,
      titleTextStyle: _displaySmallTextDark,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: _primaryColorDark,
      ),
      iconTheme: IconThemeData(
        color: _textPrimaryDark,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith((states) => _displayMediumTextDark),
      color: _primaryColorDark,
      elevation: 8,
    ),
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      indicatorColor: _secondaryColorDark,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: _primaryColorDark,
      surfaceTintColor: _secondaryColorDark,
    ),
    textTheme: _textThemeDark,
    colorScheme: const ColorScheme.dark(
      surface: _backgroundColorDark,
      primary: _primaryColorDark,
      onPrimary: _onPrimaryColorDark,
      inversePrimary: _textPrimaryDark,
      secondary: _secondaryColorDark,
      onSecondary: _onSecondaryColorDark,
      tertiary: _tertiaryColorDark,
      error: _errorColor,
    ),
    cardTheme: CardTheme(
      color: _primaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular( 10 ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: _secondaryColorDark,
      size: 22,
    ),
    tooltipTheme: TooltipThemeData(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _secondaryColorDark,
        borderRadius: BorderRadius.circular(5),
      ),
      showDuration: const Duration(seconds: 5),
      textStyle: _bodySmallTextDark,
      preferBelow: true,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: _tertiaryColorDark,
      color: _secondaryColorDark,
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: _textPrimaryDark,
      titleTextStyle: TextStyle(
        color: _primaryColorDark,
        fontSize: 20,
      ),
      contentTextStyle: TextStyle(
        color: _primaryColorDark,
      ),
    ),
    dividerTheme: _dividerThemeDataDark,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      labelStyle: _bodyMediumTextDark,
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: _onSecondaryColorDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: _onSecondaryColorDark,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColorDark,
        padding: const EdgeInsets.all(12),
        side: const BorderSide(
          color: _primaryColorDark,
          width: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _secondaryColorDark,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular( 30 ),
      ),
    ),
  );
}