import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppTheme {
  ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 11, 11, 11),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 11, 11, 11),
    );
  }
}

final appThemeProvider = Provider<AppTheme>((_) => AppTheme());
