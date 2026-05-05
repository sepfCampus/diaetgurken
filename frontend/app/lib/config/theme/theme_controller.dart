import 'package:app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier
{
  bool _highContrast = false;
  bool _largeFont = false;

  ThemeData get theme => AppTheme.getTheme(
    highContrast: _highContrast,
    largeFont: _largeFont,
  );

  String get colorSelection => _highContrast ? 'Hoher Kontrast' : 'Standard';

  String get fontSizeSelection => _largeFont ? 'Groß' : 'Standard';

  bool get largeFont => _largeFont;

  void setColorSelection(String value)
  {
    _highContrast = value == 'Hoher Kontrast';
    notifyListeners();
  }

  void setFontSizeSelection(String value)
  {
    _largeFont = value == 'Groß';
    notifyListeners();
  }
}