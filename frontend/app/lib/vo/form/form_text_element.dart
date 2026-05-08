import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_type.dart';

class FormTextElement extends FormBaseElement
{
  String? defaultValue;

  FormTextElement(String name, String? displayName, this.defaultValue):super(FormElementType.TEXT, name, displayName);

  factory FormTextElement.fromJson(Map<String, dynamic> json)
  {
    return FormTextElement(json['name'], json['displayName'], json['defaultValue']);
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name': name, 'displayName': displayName, 'defaultValue': defaultValue };
  }
}
