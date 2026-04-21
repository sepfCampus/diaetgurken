import 'package:app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier
{
  ThemeData _theme = AppTheme.STANDARD;

  ThemeData get theme => _theme;

  void setTheme(ThemeData theme)
  {
    _theme = theme;
    notifyListeners();
  }
}
