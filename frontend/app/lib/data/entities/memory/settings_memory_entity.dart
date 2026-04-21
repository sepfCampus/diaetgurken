import 'package:app/data/entities/settings_entity.dart';

class SettingsMemoryEntity extends SettingsEntity
{
  final int _userId;

  SettingsMemoryEntity(this._userId, super._farbdarstellung, super._schriftgroesse);

  int get userId => this._userId;
}
