import 'package:app/data/entities/user_entity.dart';

class UserHttpEntity extends UserEntity
{
  UserHttpEntity(super._id, super._email, super._registerNr);

  factory UserHttpEntity.fromJson(Map<String, dynamic> json)
  {
    return UserHttpEntity(json['id'], json['email'], json['registerNr']);
  }

  Map<String, dynamic> toJson()
  {
    return { 'id': id, 'email': email, 'registerNr': registerNr };
  }
}
