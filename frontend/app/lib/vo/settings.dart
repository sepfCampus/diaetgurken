class Settings {
  String _colorMode;
  String _fontSize;

  Settings(this._colorMode, this._fontSize);

  String get colorMode => _colorMode;
  String get fontSize => _fontSize;

  set colorMode(String value) {
    _colorMode = value;
  }

  set fontSize(String value) {
    _fontSize = value;
  }
}
