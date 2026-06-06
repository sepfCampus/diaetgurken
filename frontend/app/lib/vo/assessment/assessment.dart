import 'package:app/vo/assessment/assessment_element.dart';

class Assessment
{
  Map<String, AssessmentElement> elements = {};

  Assessment(List<AssessmentElement> elements)
  {
    for(final element in elements)
    {
      this.elements[element.fieldName] = element;
    }
  }

  dynamic getValue(String fieldName)
  {
    return elements[fieldName]?.value;
  }

  void setValue(String fieldName, dynamic value)
  {
    elements[fieldName] = AssessmentElement(fieldName, value, elements[fieldName]?.noAnswerProvided ?? false);
  }

  bool hasAnswer(String fieldName)
  {
    if(elements[fieldName] == null)
    {
      return false;
    }

    return !(elements[fieldName]!.noAnswerProvided);
  }

  void setNoAnswerProvided(String fieldName, bool noAnswerProvided)
  {
    elements[fieldName] = AssessmentElement(fieldName, elements[fieldName]?.value, noAnswerProvided);
  }

  factory Assessment.fromJson(Map<String, dynamic> json)
  {
    final rawElements = json['elements'] as List<dynamic>? ?? [];

    return Assessment(rawElements.map((element) => AssessmentElement.fromJson(element)).toList());
  }

  Map<String, dynamic> toJson()
  {
    return { 'elements': elements.values.map((element) => element.toJson()).toList() };
  }
}
