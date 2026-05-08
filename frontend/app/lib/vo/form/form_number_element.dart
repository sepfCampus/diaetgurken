import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_type.dart';

class FormNumberElement extends FormBaseElement
{
  bool isInteger;
  double? defaultValue;

  FormNumberElement(String name, String? displayName, this.isInteger, this.defaultValue):super(FormElementType.NUMBER, name, displayName);

  factory FormNumberElement.fromJson(Map<String, dynamic> json)
  {
    return FormNumberElement(json['name'], json['displayName'], json['isInteger'] ?? false, (json['defaultValue'] as num?)?.toDouble());
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name':name, 'displayName': displayName, 'defaultValue': defaultValue, 'isInteger': isInteger };
  }
}
