import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_type.dart';

class FormTrueFalseElement extends FormBaseElement
{
  bool? defaultValue;

  FormTrueFalseElement(String name, String? displayName, this.defaultValue):super(FormElementType.TRUE_FALSE, name, displayName);

  factory FormTrueFalseElement.fromJson(Map<String, dynamic> json)
  {
    return FormTrueFalseElement(json['name'], json['displayName'], json['defaultValue']);
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name': name, 'displayName': displayName, 'defaultValue': defaultValue };
  }
}
