import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_type.dart';
import 'package:app/vo/form/form_element_category.dart';

class FormTextElement extends FormBaseElement
{
  String? defaultValue;

  FormTextElement(String name, String? displayName, FormElementCategory category, List<String> filterOptions, this.defaultValue):super(FormElementType.TEXT, name, displayName, category, filterOptions);

  factory FormTextElement.fromJson(Map<String, dynamic> json)
  {
    return FormTextElement(json['name'], json['displayName'], FormElementCategory.fromName(json['category'] ?? 'body'), List<String>.from(json['filterOptions'] ?? []), json['defaultValue']);
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name': name, 'displayName': displayName, 'category': category.name, 'filterOptions': filterOptions, 'defaultValue': defaultValue };
  }
}
