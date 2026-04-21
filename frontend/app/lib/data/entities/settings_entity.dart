abstract class SettingsEntity
{
  final String _farbdarstellung;
  final String _schriftgroesse;

  SettingsEntity(this._farbdarstellung, this._schriftgroesse);

  String get farbdarstellung => this._farbdarstellung;
  String get schriftgroesse => this._schriftgroesse;
}
