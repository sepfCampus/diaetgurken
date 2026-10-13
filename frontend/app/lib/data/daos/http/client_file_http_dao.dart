import 'dart:convert';
import 'package:app/data/daos/client_file_base_dao.dart';
import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/entities/http/client_file_http_entity.dart';
import 'package:app/vo/client_file_summary.dart';

class ClientFileHttpDao extends ClientFileBaseDao<ClientFileHttpEntity>
{
  final ApiClient apiClient;

  ClientFileHttpDao({ required this.apiClient });

  @override
  Future<List<ClientFileHttpEntity>> getAll() async
  {
    final response = await apiClient.get('/users/klientenakten');

    if(!response.isSuccess)
    {
      throw Exception("Laden der Klientenakten ist fehlgeschlagen.");
    }

    final List<dynamic> json = jsonDecode(response.body);
    final List<ClientFileHttpEntity> clientFiles = [];

    for(int i = 0; i < json.length; i++)
    {
      clientFiles.add(ClientFileHttpEntity.fromJson(json[i] as Map<String, dynamic>));
    }

    return clientFiles;
  }

  @override
  Future<void> create(String clearName) async
  {
    final response = await apiClient.post('/users/klientenakten', body:
                                          {
                                            'name': clearName
                                          });
    
    if(!response.isSuccess)
    {
      throw Exception('Fehler beim Anlegen der Klientenakte.');
    }
  }

  @override
  Future<void> delete(int id) async
  {
    final response = await apiClient.delete('/users/klientenakten/$id');

    if(!response.isSuccess)
    {
      throw Exception('Fehler beim Löschen der Klientenakte.');
    }
  }

  @override
  Future<String> getClearName(String clientFileId, String password) async
  {
    final response = await apiClient.post('/users/klientenakten/$clientFileId/klarname', body:
                                          {
                                            'password': password
                                          });

    if(!response.isSuccess)
    {
      throw Exception('Fehler beim Laden des Klarnamens.');
    }

    else
    {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['name'] as String;
    }
  }

  @override
  Future<ClientFileSummary> generateSummary(int id) async
  {
    final response = await apiClient.post('/users/klientenakten/$id/summary');

    if(!response.isSuccess)
    {
      String message = 'Zusammenfassung konnte nicht erstellt werden.';

      try
      {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if(data['error'] is String)
        {
          message = data['error'] as String;
        }
      }
      catch(_)
      {
        // Bei nicht lesbarer Fehlerantwort bleibt die allgemeine Meldung erhalten.
      }

      throw Exception(message);
    }

    try
    {
      return ClientFileSummary.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    catch(_)
    {
      throw Exception('Ungültige Antwort des Zusammenfassungsdienstes.');
    }
  }
}
