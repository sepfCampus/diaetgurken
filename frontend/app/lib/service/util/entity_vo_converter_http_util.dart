import 'package:app/data/entities/http/client_file_http_entity.dart';
import 'package:app/data/entities/http/conversation_http_entity.dart';
import 'package:app/data/entities/http/settings_http_entity.dart';
import 'package:app/data/entities/http/user_http_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';
import 'package:app/vo/client_file.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/user.dart';

class EntityVoConverterHttpUtil extends EntityVoConverterBaseUtil<SettingsHttpEntity, UserHttpEntity, ConversationHttpEntity, ClientFileHttpEntity>
{
  @override
  Settings convertSettingsEntityToVo(SettingsHttpEntity settingsentity) => Settings(settingsentity.farbdarstellung, settingsentity.schriftgroesse);
  
  @override
  SettingsHttpEntity convertSettingsVoToEntity(int userId, Settings settings) => SettingsHttpEntity(userId, settings.colorMode, settings.fontSize);

  @override
  User convertUserEntityToVo(UserHttpEntity user) => User(user.id, user.registerNr, user.email);

  @override
  UserHttpEntity convertUserVoToEntity(User user) => UserHttpEntity(user.id, user.email, user.registerNr);

  @override
  Conversation convertConversationEntityToVo(ConversationHttpEntity conversation) => Conversation(conversation.id, conversation.datum, conversation.formMetaData, conversation.assessment, conversation.diagnosen, conversation.ziele, conversation.outcome, conversation.notizen, conversation.selectedFilters);

  @override
  ConversationHttpEntity convertConversationToEntity(Conversation conversation, int clientFileId) => ConversationHttpEntity(conversation.id, clientFileId, conversation.datum, conversation.formMetaData, conversation.assessment, conversation.diagnosen, conversation.ziele, conversation.outcome, conversation.notizen, conversation.selectedFilters);

  @override
  ClientFile convertClientFileEntityToVo(ClientFileHttpEntity clientFile, User user, List<Conversation> conversations) => ClientFile(clientFile.id, user, conversations);
  
  @override
  ClientFileHttpEntity convertClientFileToEntity(ClientFile clientFile) => ClientFileHttpEntity(clientFile.id, clientFile.user.id);
}
