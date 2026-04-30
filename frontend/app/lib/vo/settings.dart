class Settings
{
  String _colorMode;
  String _fontSize;

  Settings(this._colorMode, this._fontSize);

  String get colorMode => this._colorMode;
  String get fontSize => this._fontSize;

  void set colorMode(String value)
  {
    this._colorMode = value;
  }

  void set fontSize(String value)
  {
    this._fontSize = value;
  }
}
