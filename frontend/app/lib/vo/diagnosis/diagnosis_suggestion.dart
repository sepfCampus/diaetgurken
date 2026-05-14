import 'package:app/vo/diagnosis/diagnosis_suggestion_condition.dart';

class DiagnosisSuggestion
{
  String suggestedValue;
  List<DiagnosisSuggestionCondition> conditions;

  DiagnosisSuggestion({ required this.suggestedValue, required this.conditions });

  factory DiagnosisSuggestion.fromJson(Map<String, dynamic> json)
  {
    return DiagnosisSuggestion(suggestedValue: json['suggestedValue'] ?? '',
                               conditions: (json['conditions'] as List<dynamic>? ?? [])
                                           .map((condition) => DiagnosisSuggestionCondition.fromJson(condition))
                                           .toList());
  }
}
