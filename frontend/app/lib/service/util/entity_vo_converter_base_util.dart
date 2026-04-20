import 'package:app/data/entities/settings_entity.dart';
import 'package:app/vo/Settings.dart';

abstract class EntityVoConverterBaseUtil<SettingsXEntity extends SettingsEntity> //the X in the name of the type parameters stands for unknown data source
{
  Settings convertEntityToVo(SettingsXEntity settings);
  SettingsXEntity convertVoToEntity(int userId, Settings settings);
}
