import 'package:app/data/entities/http/client_file_http_entity.dart';
import 'package:app/data/entities/http/conversation_http_entity.dart';
import 'package:app/data/entities/http/settings_http_entity.dart';
import 'package:app/data/entities/http/user_http_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/Settings.dart';
import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/client_file.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/diagnosis/diagnosis.dart';
import 'package:app/vo/form/form_meta_data.dart';
import 'package:app/vo/goal/goals.dart';
import 'package:app/vo/outcome/outcome.dart';
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
  Conversation convertConversationEntityToVo(ConversationHttpEntity conversation)
  {
    return Conversation(conversation.id, conversation.datum,
                        FormMetaData.fromJson(conversation.formMetaData),
                        Assessment.fromJson(conversation.assessment),
                        Diagnosis.fromJson(conversation.diagnosen),
                        Goals.fromJson(conversation.ziele),
                        Outcome.fromJson(conversation.outcome),
                        conversation.notizen, conversation.selectedFilters);
  }

  @override
  ConversationHttpEntity convertConversationToEntity(Conversation conversation, int clientFileId)
  {
    return ConversationHttpEntity(conversation.id, clientFileId, conversation.datum,
                                  conversation.formMetaData.toJson(),
                                  conversation.assessment.toJson(),
                                  conversation.diagnosen.toJson(),
                                  conversation.ziele.toJson(),
                                  conversation.outcome.toJson(),
                                  conversation.notizen, conversation.selectedFilters);
  }

  @override
  ClientFile convertClientFileEntityToVo(ClientFileHttpEntity clientFile, User user, List<Conversation> conversations) => ClientFile(clientFile.id, user, conversations);
  
  @override
  ClientFileHttpEntity convertClientFileToEntity(ClientFile clientFile) => ClientFileHttpEntity(clientFile.id, clientFile.user.id);
}
