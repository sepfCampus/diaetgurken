import 'package:app/data/entities/client_file_entity.dart';

class ClientFileHttpEntity extends ClientFileEntity
{
  ClientFileHttpEntity(super._id, super._userId);

  factory ClientFileHttpEntity.fromJson(Map<String, dynamic> json)
  {
    return ClientFileHttpEntity(json['id'], json['userId']);
  }

  Map<String, dynamic> toJson()
  {
    return { 'id': id, 'userId': userId };
  }
}
