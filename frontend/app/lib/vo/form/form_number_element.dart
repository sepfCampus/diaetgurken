import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_category.dart';
import 'package:app/vo/form/form_element_type.dart';

class FormNumberElement extends FormBaseElement
{
  bool isInteger;
  double? defaultValue;

  FormNumberElement(String name, String? displayName, FormElementCategory category, List<String> filterOptions, this.isInteger, this.defaultValue):super(FormElementType.NUMBER, name, displayName, category, filterOptions);

  factory FormNumberElement.fromJson(Map<String, dynamic> json)
  {
    return FormNumberElement(json['name'], json['displayName'], FormElementCategory.fromName(json['category'] ?? 'body'), List<String>.from(json['filterOptions'] ?? []), json['isInteger'] ?? false, (json['defaultValue'] as num?)?.toDouble());
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name':name, 'displayName': displayName, 'category': category.name, 'filterOptions': filterOptions, 'defaultValue': defaultValue, 'isInteger': isInteger };
  }
}
