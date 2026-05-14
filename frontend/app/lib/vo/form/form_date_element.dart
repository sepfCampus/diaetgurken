import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_type.dart';
import 'package:app/vo/form/form_element_category.dart';

class FormDateElement extends FormBaseElement
{
  DateTime? defaultValue;

  FormDateElement(String name, String? displayName, FormElementCategory category, List<String> filterOptions, this.defaultValue):super(FormElementType.DATE, name, displayName, category, filterOptions);

  factory FormDateElement.fromJson(Map<String, dynamic> json)
  {
    return FormDateElement(json['name'], json['displayName'], FormElementCategory.fromName(json['category'] ?? 'body'), List<String>.from(json['filterOptions'] ?? []), json['defaultValue'] == null ? null : DateTime.parse(json['defaultValue']));
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name': name, 'displayName': displayName, 'category': category, 'filterOptions': filterOptions, 'defaultValue': defaultValue?.toIso8601String() };
  }
}
