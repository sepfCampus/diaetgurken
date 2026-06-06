import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_category.dart';
import 'package:app/vo/form/form_element_type.dart';

class FormTrueFalseElement extends FormBaseElement
{
  bool? defaultValue;

  FormTrueFalseElement(String name, String? displayName, FormElementCategory category, List<String> filterOptions, this.defaultValue):super(FormElementType.TRUE_FALSE, name, displayName, category, filterOptions);

  factory FormTrueFalseElement.fromJson(Map<String, dynamic> json)
  {
    return FormTrueFalseElement(json['name'], json['displayName'], FormElementCategory.fromName(json['category'] ?? 'body'), List<String>.from(json['filterOptions'] ?? []), json['defaultValue']);
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name': name, 'displayName': displayName, 'category': category.name, 'filterOptions': filterOptions, 'defaultValue': defaultValue };
  }
}
