import 'package:app/vo/form/form_base_element.dart';

class FormMetaData
{
  List<FormBaseElement> elements;

  FormMetaData(this.elements);

  factory FormMetaData.fromJson(Map<String, dynamic> json)
  {
    final rawElements = json['elements'] as List<dynamic>? ?? [];

    return FormMetaData(rawElements.map((rawElement) => FormBaseElement.fromJson(rawElement)).toList());
  }

  Map<String, dynamic> toJson()
  {
    return { 'elements': elements.map((element) => element.toJson()).toList() };
  }
}
