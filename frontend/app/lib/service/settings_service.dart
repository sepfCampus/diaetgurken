import 'package:app/data/daos/settings_base_dao.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/service/settings_base_service.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';

class SettingsService implements SettingsBaseService {
  final SettingsBaseDao<SettingsEntity> _settingsDao;
  final EntityVoConverterBaseUtil<SettingsEntity> _entityVoConverterUtil;

  SettingsService(this._settingsDao, this._entityVoConverterUtil);

  @override
  Future<Settings> getSettings(int userId) async {
    SettingsEntity settingsEntity = await _settingsDao.getSettings(userId);
    return _entityVoConverterUtil.convertEntityToVo(settingsEntity);
  }

  @override
  void updateSettings(int userId, Settings settings) async {
    _settingsDao.updateSettings(
      _entityVoConverterUtil.convertVoToEntity(userId, settings),
    );
  }
}
