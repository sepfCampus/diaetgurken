import 'dart:async';

import 'package:app/data/daos/client_file_base_dao.dart';
import 'package:app/data/entities/client_file_entity.dart';
import 'package:app/data/entities/conversation_entity.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/service/conversation_service.dart';
import 'package:app/service/user_service.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/client_file.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/user.dart';

class ClientFileService
{
  ClientFileBaseDao<ClientFileEntity> _clientFileDao;
  EntityVoConverterBaseUtil<SettingsEntity, UserEntity, ConversationEntity, ClientFileEntity> _entityVoConverterUtil;

  UserService _userService;
  ConversationService _conversationService;

  ClientFileService(this._clientFileDao, this._entityVoConverterUtil, this._userService, this._conversationService);

  Future<List<ClientFile>> getAll({ bool? loadConversations = false }) async
  {
    List<ClientFileEntity> clientFileEntities = await this._clientFileDao.getAll();
    User user = await this._userService.getCurrentUser();

    List<ClientFile> clientFiles = [];

    for(int i = 0; i < clientFileEntities.length; i++)
    {
      List<Conversation> conversations = [];

      if(loadConversations == true)
      {
        conversations = await this._conversationService.getAll(clientFileEntities[i].id);
      }

      clientFiles.add(this._entityVoConverterUtil.convertClientFileEntityToVo(clientFileEntities[i], user, conversations));
    }

    return clientFiles;
  }
  
  Future<void> create(String clearName) async
  {
    await this._clientFileDao.create(clearName);
  }

  Future<void> delete(int id) async
  {
    await this._clientFileDao.delete(id);
  }

  Future<String> getClearName(String clientFileId, String password) async
  {
    String clearName = await this._clientFileDao.getClearName(clientFileId, password);
    return clearName;
  }
}
