import 'dart:convert';
import 'package:app/data/daos/client_file_base_dao.dart';
import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/entities/http/client_file_http_entity.dart';

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
}
