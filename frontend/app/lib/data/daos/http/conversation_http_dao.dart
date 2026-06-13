import 'dart:convert';
import 'dart:typed_data';

import 'package:app/data/daos/conversation_base_dao.dart';
import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/entities/http/conversation_http_entity.dart';
import 'package:app/vo/util/date_util.dart';

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
      ConversationHttpEntity conversationHttpEntity = ConversationHttpEntity.fromJson(json[i] as Map<String, dynamic>);

      //the date needs to be reformatted
      conversations.add(ConversationHttpEntity(conversationHttpEntity.id, conversationHttpEntity.klientenAktenId, DateUtil.formatDate(conversationHttpEntity.datum), conversationHttpEntity.formMetaData, conversationHttpEntity.assessment, conversationHttpEntity.diagnosen, conversationHttpEntity.ziele, conversationHttpEntity.outcome, conversationHttpEntity.notizen, conversationHttpEntity.selectedFilters));
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
  Future<ConversationHttpEntity> create(ConversationHttpEntity conversation) async
  {
    final response = await apiClient.post('/users/klientenakten/${conversation.klientenAktenId}/gespraech', body: conversation.toJson());

    if(!response.isSuccess)
    {
      throw Exception(_extractErrorMessage(response.body, 'Fehler beim Speichern des Gesprächs.'));
    }

    ConversationHttpEntity conversationHttpEntity = ConversationHttpEntity.fromJson(json.decode(response.body) as Map<String, dynamic>);

    //the date needs to be reformatted
    ConversationHttpEntity result = ConversationHttpEntity(conversationHttpEntity.id, conversationHttpEntity.klientenAktenId, DateUtil.formatDate(conversationHttpEntity.datum), conversationHttpEntity.formMetaData, conversationHttpEntity.assessment, conversationHttpEntity.diagnosen, conversationHttpEntity.ziele, conversationHttpEntity.outcome, conversationHttpEntity.notizen, conversationHttpEntity.selectedFilters);

    return result;
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

  String _extractErrorMessage(String body, String fallback)
  {
    try
    {
      final decoded = jsonDecode(body);

      if(decoded is Map<String, dynamic>)
      {
        final error = decoded['error'];

        if(error is String && error.isNotEmpty)
        {
          return error;
        }
      }
    }

    catch(_)
    {
      // Use fallback for non-JSON error bodies.
    }

    return fallback;
  }

  Future<Uint8List> exportPdf({ required int clientId, required int conversationId,
                                String fontSize = 'standard', String theme = 'standard'}) async
  {
    final response = await apiClient.getBytes(
      '/users/klientenakten/$clientId/gespraech/$conversationId/export/pdf'
      '?schriftgroesse=$fontSize&kontrast=$theme');

    if(!response.isSuccess || response.bodyBytes == null)
    {
      throw Exception('PDF-Export fehlgeschlagen.');
    }

    return response.bodyBytes!;
  }

  Future<Uint8List> exportDocx({ required int clientId, required int conversationId,
                                 String fontSize = 'standard', String theme = 'standard' }) async {
    final response = await apiClient.getBytes(
      '/users/klientenakten/$clientId/gespraech/$conversationId/export/docx'
      '?schriftgroesse=$fontSize&kontrast=$theme');

    if(!response.isSuccess || response.bodyBytes == null)
    {
      throw Exception('Word-Export fehlgeschlagen.');
    }

    return response.bodyBytes!;
  }
}
