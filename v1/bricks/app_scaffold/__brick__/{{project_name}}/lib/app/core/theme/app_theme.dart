import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppTheme {
  ThemeData get lightTheme {
    // TODO: Add light theme
    return ThemeData(
      scaffoldBackgroundColor: Colors.blueGrey,
    );
  }

  ThemeData get darkTheme {
    // TODO: Add dark theme
    return ThemeData(
      scaffoldBackgroundColor: Colors.blueGrey,
    );
  }
}

final appThemeProvider = Provider<AppTheme>((_) => AppTheme());
