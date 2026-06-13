import 'dart:convert';
import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/daos/settings_base_dao.dart';
import 'package:app/data/entities/http/settings_http_entity.dart';

class SettingsHttpDao implements SettingsBaseDao<SettingsHttpEntity>
{
  final ApiClient apiClient;

  SettingsHttpDao({ required this.apiClient });

  @override
  Future<SettingsHttpEntity> getSettings(int userId) async
  {
    final response = await apiClient.get('/users/einstellung');

    if(!response.isSuccess)
    {
      //TODO: create exception class for this
      throw Exception('Einstellungen konnten nicht geladen werden. ${response.statusCode}');
    }

    final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;

    return SettingsHttpEntity(json['userId'] as int? ?? userId,
                              json['farbdarstellung'] as String? ?? 'Standard',
                              json['schriftgroesse'] as String? ?? 'Standard');
  }

  @override
  Future<void> updateSettings(SettingsHttpEntity settings) async
  {
    final response = await apiClient.put('/users/einstellung',
      body:
      {
        'farbdarstellung': settings.farbdarstellung,
        'schriftgroesse': settings.schriftgroesse
      },
    );

    if(!response.isSuccess)
    {
      throw Exception('Einstellungen konnten nicht gespeichert werden.');
    }
  }
}
