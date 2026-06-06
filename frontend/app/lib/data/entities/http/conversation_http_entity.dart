import 'package:app/data/entities/conversation_entity.dart';

class ConversationHttpEntity extends ConversationEntity
{
  ConversationHttpEntity(super._id, super._klientenAktenId, super._datum,
                         super._formMetaData, super._assessment, super._diagnosen,
                         super._ziele, super._outcome, super._notizen, super._selectedFilters);

  factory ConversationHttpEntity.fromJson(Map<String, dynamic> json)
  {
    return ConversationHttpEntity(json['id'], json['klientenAkteId'] ?? json['klientenAktenId'], json['datum'],
                                  Map<String, dynamic>.from(json['formMetaData'] ?? {}),
                                  Map<String, dynamic>.from(json['assessment'] ?? {}),
                                  Map<String, dynamic>.from(json['diagnosen'] ?? {}),
                                  Map<String, dynamic>.from(json['ziele'] ?? {}),
                                  Map<String, dynamic>.from(json['outcome'] ?? {}),
                                  json['notizen'] as String? ?? '',
                                  (json['selectedFilters'] as List<dynamic>? ?? []).cast<String>());
  }

  Map<String, dynamic> toJson()
  {
    return { 'id': id, 'klientenAkteId': klientenAktenId, 'datum': datum,
             'formMetaData': formMetaData, 'assessment': assessment, 'diagnosen': diagnosen,
             'ziele': ziele, 'outcome': outcome, 'notizen': notizen, 'selectedFilters': selectedFilters };
  }
}
