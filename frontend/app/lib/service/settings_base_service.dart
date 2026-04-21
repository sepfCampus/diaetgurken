import 'package:app/vo/Settings.dart';

abstract class SettingsBaseService
{
  Future<Settings> getSettings(int userId);
  void updateSettings(int userId, Settings settings);
}
