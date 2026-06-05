import 'package:app/data/daos/settings_base_dao.dart';
import 'package:app/data/entities/client_file_entity.dart';
import 'package:app/data/entities/conversation_entity.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';

class SettingsService
{
  SettingsBaseDao<SettingsEntity> _settingsDao;
  EntityVoConverterBaseUtil<SettingsEntity, UserEntity, ConversationEntity, ClientFileEntity> _entityVoConverterUtil;

  SettingsService(this._settingsDao, this._entityVoConverterUtil);

  Future<Settings> getSettings(int userId) async
  {
    SettingsEntity settingsEntity = await this._settingsDao.getSettings(userId);
    return this._entityVoConverterUtil.convertSettingsEntityToVo(settingsEntity);
  }

  void updateSettings(int userId, Settings settings) async
  {
    this._settingsDao.updateSettings(this._entityVoConverterUtil.convertSettingsVoToEntity(userId, settings));
  }
}
