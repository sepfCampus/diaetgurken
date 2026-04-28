abstract class SettingsEntity
{
  final int _userId;
  final String _farbdarstellung;
  final String _schriftgroesse;

  SettingsEntity(this._userId, this._farbdarstellung, this._schriftgroesse);

  int get userId => this._userId;
  String get farbdarstellung => this._farbdarstellung;
  String get schriftgroesse => this._schriftgroesse;
}
