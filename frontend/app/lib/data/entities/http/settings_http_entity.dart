import 'package:app/data/entities/settings_entity.dart';

class SettingsHttpEntity extends SettingsEntity
{
  final int _userId;

  SettingsHttpEntity(this._userId, super._farbdarstellung, super._schriftgroesse);

  int get userId => this._userId;
}
