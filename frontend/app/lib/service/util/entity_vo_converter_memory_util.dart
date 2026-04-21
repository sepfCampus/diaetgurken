import 'package:app/data/entities/memory/settings_memory_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';

class EntityVoConverterMemoryUtil extends EntityVoConverterBaseUtil<SettingsMemoryEntity>
{
  @override
  Settings convertEntityToVo(SettingsMemoryEntity settingsentity) => Settings(settingsentity.farbdarstellung, settingsentity.schriftgroesse);
  
  @override
  SettingsMemoryEntity convertVoToEntity(int userId, Settings settings) => SettingsMemoryEntity(userId, settings.colorMode, settings.fontSize);
}
