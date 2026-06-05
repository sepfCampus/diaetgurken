import 'package:app/data/entities/settings_entity.dart';

class SettingsHttpEntity extends SettingsEntity
{
  SettingsHttpEntity(super._userId, super._farbdarstellung, super._schriftgroesse);

  factory SettingsHttpEntity.fromJson(Map<String, dynamic> json)
  {
    return SettingsHttpEntity(json['userId'], json['farbdarstellung'], json['schriftgroesse']);
  }

  Map<String, dynamic> toJson()
  {
    return { 'userId': userId, 'farbdarstellung': farbdarstellung, 'schriftgroesse': schriftgroesse };
  }
}
