import 'package:app/data/entities/http/settings_http_entity.dart';
import 'package:app/data/entities/http/user_http_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';
import 'package:app/vo/user.dart';

class EntityVoConverterHttpUtil extends EntityVoConverterBaseUtil<SettingsHttpEntity, UserHttpEntity>
{
  @override
  Settings convertSettingsEntityToVo(SettingsHttpEntity settingsentity) => Settings(settingsentity.farbdarstellung, settingsentity.schriftgroesse);
  
  @override
  SettingsHttpEntity convertSettingsVoToEntity(int userId, Settings settings) => SettingsHttpEntity(userId, settings.colorMode, settings.fontSize);

  @override
  User convertUserEntityToVo(UserHttpEntity user) => User(user.id, user.registerNr, user.email);

  UserHttpEntity convertUserVoToEntity(User user) => UserHttpEntity(user.id, user.email, user.registerNr);
}
