import 'package:app/data/daos/settings_base_dao.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/service/settings_base_service.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';

class SettingsService implements SettingsBaseService
{
  SettingsBaseDao<SettingsEntity> _settingsDao;
  EntityVoConverterBaseUtil<SettingsEntity, UserEntity> _entityVoConverterUtil;

  SettingsService(this._settingsDao, this._entityVoConverterUtil);

  @override
  Future<Settings> getSettings(int userId) async
  {
    SettingsEntity settingsEntity = await this._settingsDao.getSettings(userId);
    return this._entityVoConverterUtil.convertSettingsEntityToVo(settingsEntity);
  }

  @override
  void updateSettings(int userId, Settings settings) async
  {
    this._settingsDao.updateSettings(this._entityVoConverterUtil.convertSettingsVoToEntity(userId, settings));
  }
}
