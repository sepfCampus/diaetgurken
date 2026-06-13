import 'package:app/data/entities/client_file_entity.dart';
import 'package:app/data/entities/conversation_entity.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/vo/settings.dart';
import 'package:app/vo/client_file.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/user.dart';

abstract class EntityVoConverterBaseUtil<SettingsXEntity extends SettingsEntity,
                                         UserXEntity extends UserEntity,
                                         ConversationXEntity extends ConversationEntity,
                                         ClientFileXEntity extends ClientFileEntity> //the X in the name of the type parameters stands for unknown data source
{
  Settings convertSettingsEntityToVo(SettingsXEntity settings);
  SettingsXEntity convertSettingsVoToEntity(int userId, Settings settings);

  User convertUserEntityToVo(UserXEntity user);
  UserXEntity convertUserVoToEntity(User user);

  Conversation convertConversationEntityToVo(ConversationXEntity conversation);
  ConversationXEntity convertConversationToEntity(Conversation conversation, int clientFileId);

  ClientFile convertClientFileEntityToVo(ClientFileXEntity clientFile, User user, List<Conversation> conversations);
  ClientFileXEntity convertClientFileToEntity(ClientFile clientFile);
}
