
import 'package:app/data/daos/settings_base_dao.dart';
import 'package:app/data/entities/memory/settings_memory_entity.dart';

class SettingsMemoryDao extends SettingsBaseDao<SettingsMemoryEntity>
{
  static int _nextId = 0;
  static Map<int, SettingsMemoryEntity> settingsEntities = Map<int, SettingsMemoryEntity>();

  SettingsMemoryDao()
  {
    settingsEntities[_nextId++] = SettingsMemoryEntity(0, 'Standard', 'Standard');
    settingsEntities[_nextId++] = SettingsMemoryEntity(1, 'Hoher Kontrast', 'Standard');
  }

  @override
  Future<SettingsMemoryEntity> getSettings(int userId) async
  {
    SettingsMemoryEntity? settings = settingsEntities[userId];
    
    if(settings != null)
    {
      return settings;
    }

    else
    {
      throw Exception("Muss noch eine eigene Exception hierfür schreiben.");
    }
  }

  @override
  Future<void> updateSettings(SettingsMemoryEntity settings) async
  {
    settingsEntities[settings.userId] = settings;
  }
}
