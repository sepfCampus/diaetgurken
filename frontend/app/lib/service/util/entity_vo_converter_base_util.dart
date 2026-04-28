import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/vo/Settings.dart';
import 'package:app/vo/user.dart';

abstract class EntityVoConverterBaseUtil<SettingsXEntity extends SettingsEntity,
                                         UserXEntity extends UserEntity> //the X in the name of the type parameters stands for unknown data source
{
  Settings convertSettingsEntityToVo(SettingsXEntity settings);
  SettingsXEntity convertSettingsVoToEntity(int userId, Settings settings);

  User convertUserEntityToVo(UserXEntity user);
  UserXEntity convertUserVoToEntity(User user);
}
