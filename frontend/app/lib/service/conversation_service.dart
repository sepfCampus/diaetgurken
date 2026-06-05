import 'dart:async';

import 'package:app/data/daos/conversation_base_dao.dart';
import 'package:app/data/entities/client_file_entity.dart';
import 'package:app/data/entities/conversation_entity.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/conversation.dart';

class ConversationService
{
  ConversationBaseDao<ConversationEntity> _conversationDao;
  EntityVoConverterBaseUtil<SettingsEntity, UserEntity, ConversationEntity, ClientFileEntity> _entityVoConverterUtil;

  ConversationService(this._conversationDao, this._entityVoConverterUtil);

  Future<List<Conversation>> getAll(int clientFileId) async
  {
    List<ConversationEntity> conversationEntities = await this._conversationDao.getAll(clientFileId);

    List<Conversation> conversations = [];

    for(int i = 0; i < conversationEntities.length; i++)
    {
      conversations.add(this._entityVoConverterUtil.convertConversationEntityToVo(conversationEntities[i]));
    }

    return conversations;
  }

  Future<Conversation> getById(int clientFileId, int conversationId) async
  {
    ConversationEntity conversationEntity = await this._conversationDao.getById(clientFileId, conversationId);
    return this._entityVoConverterUtil.convertConversationEntityToVo(conversationEntity);
  }

  Future<Conversation> create(int clientFileId, String date) async
  {
    ConversationEntity conversationEntity = await this._conversationDao.create(clientFileId, date);
    return this._entityVoConverterUtil.convertConversationEntityToVo(conversationEntity);
  }

  Future<Conversation> update(Conversation conversation, int clientFileId) async
  {
    ConversationEntity conversationEntity = await this._conversationDao.update(this._entityVoConverterUtil.convertConversationToEntity(conversation, clientFileId));
    return this._entityVoConverterUtil.convertConversationEntityToVo(conversationEntity);
  }

  Future<void> delete(int clientFileId, int conversationId) async
  {
    await this._conversationDao.delete(clientFileId, conversationId);
  }
}
