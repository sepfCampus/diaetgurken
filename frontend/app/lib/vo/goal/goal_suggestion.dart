import 'package:app/vo/goal/goal_suggestion_condition.dart';

class GoalSuggestion
{
  String suggestedValue;
  List<GoalSuggestionCondition> conditions;

  GoalSuggestion({ required this.suggestedValue, required this.conditions });

  factory GoalSuggestion.fromJson(Map<String, dynamic> json)
  {
    return GoalSuggestion(suggestedValue: json['suggestedValue'] ?? '',
                          conditions: (json['conditions'] as List<dynamic>? ?? []).map((item) => GoalSuggestionCondition.fromJson(item)).toList());
  }

  Map<String, dynamic> toJson()
  {
    return { 'suggestedValue': suggestedValue, 'conditions': conditions.map((condition) => condition.toJson()).toList() };
  }
}
