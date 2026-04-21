import 'package:app/data/entities/settings_entity.dart';

abstract class SettingsBaseDao<T extends SettingsEntity>
{
  Future<T> getSettings(int userId);
  void updateSettings(T settings);
}
