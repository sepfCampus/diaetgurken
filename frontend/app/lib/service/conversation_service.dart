import 'dart:async';

import 'package:app/data/daos/conversation_base_dao.dart';
import 'package:app/data/entities/client_file_entity.dart';
import 'package:app/data/entities/conversation_entity.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/service/util/conversation_creator.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/diagnosis/diagnosis.dart';
import 'package:app/vo/outcome/outcome.dart';
import 'package:app/vo/util/outcome_creator_util.dart';

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

  Future<Conversation?> _getLastConversation(int clientFileId) async
  {
    List<Conversation> conversations = await this.getAll(clientFileId);

    int highestConversationId = -1;
    Conversation? lastConversation;

    for(int i = 0; i < conversations.length; i++)
    {
      if(highestConversationId < conversations[i].id)
      {
        lastConversation = conversations[i];
        highestConversationId = lastConversation.id;
      }
    }

    return lastConversation;
  }

  Future<Conversation> create(int clientFileId, { Conversation? conversation }) async
  {
    Conversation? lastConversation = await this._getLastConversation(clientFileId);

    Conversation conversationToCreate;

    if(lastConversation != null)
    {
      Assessment assessment = Assessment.fromJson(lastConversation.assessment.toJson()); //basically a copy operation (a new Assessment object is created)
      Diagnosis diagnosis = Diagnosis.fromJson(lastConversation.diagnosen.toJson());
      Outcome outcome = OutcomeCreatorUtil.createOutcomeFromGoals(lastConversation.ziele);
    
      conversationToCreate = conversation ?? ConversationCreator.createDefaultConversation(assessment: assessment, diagnosis: diagnosis, outcome: outcome);
    }

    else
    {
      conversationToCreate = conversation ?? ConversationCreator.createDefaultConversation();
    }

    ConversationEntity conversationEntity = await this._conversationDao.create(this._entityVoConverterUtil.convertConversationToEntity(conversationToCreate, clientFileId));
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
