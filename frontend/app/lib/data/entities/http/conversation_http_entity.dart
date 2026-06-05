import 'package:app/data/entities/conversation_entity.dart';

class ConversationHttpEntity extends ConversationEntity
{
  ConversationHttpEntity(super._id, super._klientenAktenId, super._datum,
                         super._formMetaData, super._assessment, super._diagnosen,
                         super._ziele, super._outcome, super._notizen, super._selectedFilters);
}
