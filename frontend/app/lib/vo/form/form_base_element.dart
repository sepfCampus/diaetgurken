import 'package:app/vo/form/form_date_element.dart';
import 'package:app/vo/form/form_element_type.dart';
import 'package:app/vo/form/form_number_element.dart';
import 'package:app/vo/form/form_selection_element.dart';
import 'package:app/vo/form/form_text_element.dart';
import 'package:app/vo/form/form_true_false_element.dart';
import 'package:app/vo/form/form_element_category.dart';

/**
 * The base element for all form elements in the dynamic forms.
 */
abstract class FormBaseElement
{
  FormElementType type;
  String name;
  String? displayName;
  FormElementCategory category;
  List<String> filterOptions;

  FormBaseElement(this.type, this.name, String? displayName, this.category, this.filterOptions)
  {
    this.displayName = displayName ?? this.name;
  }

  factory FormBaseElement.fromJson(Map<String, dynamic> json)
  {
    final type = FormElementType.getType(json['type']);

    switch(type)
    {
      case FormElementType.TEXT: return FormTextElement.fromJson(json);
      case FormElementType.NUMBER: return FormNumberElement.fromJson(json);
      case FormElementType.TRUE_FALSE: return FormTrueFalseElement.fromJson(json);
      case FormElementType.DATE: return FormDateElement.fromJson(json);
      case FormElementType.SELECTION: return FormSelectionElement.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}
