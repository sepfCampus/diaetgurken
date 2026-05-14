import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_element_category.dart';
import 'package:app/vo/form/form_element_type.dart';

class FormSelectionOptionElement
{
  String name;
  String text;
  bool selected;

  FormSelectionOptionElement(this.name, this.text, this.selected);

  factory FormSelectionOptionElement.fromJson(Map<String, dynamic> json)
  {
    return FormSelectionOptionElement(json['name'], json['text'], json['selected'] ?? false);
  }

  Map<String, dynamic> toJson()
  {
    return { 'name': name, 'text': text, 'selected': selected };
  }
}

class FormSelectionElement extends FormBaseElement
{
  Map<String, FormSelectionOptionElement> options = {};
  bool multipleSelection;

  FormSelectionElement(String name, String? displayName, FormElementCategory category, List<String> filterOptions, List<FormSelectionOptionElement> options, this.multipleSelection):super(FormElementType.SELECTION, name, displayName, category, filterOptions)
  {
    for(var option in options)
    {
      this.options[option.name] = option;
    }
  }

  factory FormSelectionElement.fromJson(Map<String, dynamic> json)
  {
    final rawOptions = json['options'] as List<dynamic>? ?? [];

    return FormSelectionElement(json['name'], json['displayName'], FormElementCategory.fromName(json['category'] ?? 'body'), List<String>.from(json['filterOptions'] ?? []),
                                rawOptions.map((option) => FormSelectionOptionElement.fromJson(option)).toList(),
                                json['multipleSelection'] ?? false);
  }

  @override
  Map<String, dynamic> toJson()
  {
    return { 'type': type.name, 'name': name, 'displayName': displayName, 'category': category, 'filterOptions': filterOptions, 'multipleSelection': multipleSelection, 'options': options.values.map((options) => options.toJson()).toList() };
  }
}
