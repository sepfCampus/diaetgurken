import 'package:app/data/entities/http/settings_http_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';

class EntityVoConverterHttpUtil extends EntityVoConverterBaseUtil<SettingsHttpEntity>
{
  @override
  Settings convertEntityToVo(SettingsHttpEntity settingsentity) => Settings(settingsentity.farbdarstellung, settingsentity.schriftgroesse);
  
  @override
  SettingsHttpEntity convertVoToEntity(int userId, Settings settings) => SettingsHttpEntity(userId, settings.colorMode, settings.fontSize);
}
