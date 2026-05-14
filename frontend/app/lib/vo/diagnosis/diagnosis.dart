import 'package:app/vo/diagnosis/diagnosis_element.dart';
import 'package:app/vo/diagnosis/diagnosis_suggestion.dart';

class Diagnosis
{
  List<DiagnosisElement> elements;
  Map<String, List<DiagnosisSuggestion>> suggestions;

  Diagnosis({ required this.elements, required this.suggestions });

  factory Diagnosis.emptyWithSuggestions(Map<String, List<DiagnosisSuggestion>> suggestions)
  {
    return Diagnosis(elements: [], suggestions: suggestions);
  }

  factory Diagnosis.fromJson(Map<String, dynamic> json)
  {
    final rawSuggestions = json['suggestions'] as Map<String, dynamic>? ?? {};

    return Diagnosis(
      elements: (json['elements'] as List<dynamic>? ?? [])
                .map((element) => DiagnosisElement.fromJson(element))
                .toList(),
      suggestions: rawSuggestions.map((key, value)
      {
        return MapEntry(key, (value as List<dynamic>)
                             .map((item) => DiagnosisSuggestion.fromJson(item))
                             .toList());
      })
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      'elements': elements.map((element) => element.toJson()).toList(),
      'suggestions': suggestions.map((key, value) {
        return MapEntry(
          key,
          value.map((suggestion) {
            return {
              'suggestedValue': suggestion.suggestedValue,
              'conditions': suggestion.conditions.map((condition) {
                return {
                  'fieldName': condition.fieldName,
                  'operator': condition.operator,
                  'compareValue': condition.compareValue,
                };
              }).toList(),
            };
          }).toList(),
        );
      }),
    };
  }
}
