import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_type.dart';

class FormDateElement extends FormBaseElement
{
  DateTime? defaultValue;

  FormDateElement(String name, String? displayName, this.defaultValue):super(FormElementType.DATE, name, displayName);

  factory FormDateElement.fromJson(Map<String, dynamic> json)
  {
    return FormDateElement(json['name'], json['displayName'], json['defaultValue'] == null ? null : DateTime.parse(json['defaultValue']));
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name': name, 'displayName': displayName, 'defaultValue': defaultValue?.toIso8601String() };
  }
}
