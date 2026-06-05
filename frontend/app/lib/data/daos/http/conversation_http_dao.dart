import 'dart:convert';

import 'package:app/data/daos/conversation_base_dao.dart';
import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/entities/http/conversation_http_entity.dart';

class ConversationHttpDao extends ConversationBaseDao<ConversationHttpEntity>
{
  final ApiClient apiClient;

  ConversationHttpDao({ required this.apiClient });

  @override
  Future<List<ConversationHttpEntity>> getAll(int clientFileId) async
  {
    final response = await apiClient.get('/users/klientenakten/$clientFileId/gespraeche');

    if(!response.isSuccess)
    {
      throw Exception('Fehler beim Laden der Gespräche.');
    }

    List<dynamic> json = jsonDecode(response.body);
    List<ConversationHttpEntity> conversations = [];

    for(int i = 0; i < json.length; i++)
    {
      conversations.add(ConversationHttpEntity.fromJson(json[i] as Map<String, dynamic>));
    }

    return conversations;
  }

  @override
  Future<ConversationHttpEntity> getById(int clientFileId, int conversationId) async
  {
    final conversations = await this.getAll(clientFileId);

    for(int i = 0; i < conversations.length; i++)
    {
      if(conversations[i].id == conversationId)
      {
        return conversations[i];
      }
    }

    throw Exception('Gespräch nicht gefunden.');
  }

  @override
  Future<ConversationHttpEntity> create(int clientFileId, String date) async
  {
    final response = await apiClient.post('/users/klientenakten/$clientFileId/gespraech', body:
                                          {
                                            'datum': date,
                                            'formMetaData': {},
                                            'assessment': {},
                                            'diagnosen': {},
                                            'ziele': {},
                                            'outcome': {},
                                            'notizen': '',
                                            'selectedFilters': []
                                          });

    if(!response.isSuccess)
    {
      throw Exception('Fehler beim Speichern des Gesprächs.');
    }

    return ConversationHttpEntity.fromJson(jsonDecode(response.body));
  }

  @override
  Future<ConversationHttpEntity> update(ConversationHttpEntity conversation) async
  {
    final response = await apiClient.put('/users/klientenakten/${conversation.klientenAktenId}/gespraech/${conversation.id}', body: conversation.toJson());
    
    if(!response.isSuccess)
    {
      throw Exception('Fehler beim Aktualisieren des Gesprächs.');
    }

    return ConversationHttpEntity.fromJson(jsonDecode(response.body));
  }

  @override
  Future<void> delete(int clientFileId, int conversationId) async
  {
    final response = await apiClient.delete('/users/klientenakten/$clientFileId/gespraech/$conversationId');

    if(!response.isSuccess)
    {
      throw Exception('Fehler beim Löschen des Gesprächs.');
    }
  }
}
