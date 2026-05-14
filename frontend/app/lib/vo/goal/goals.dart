import 'package:app/vo/goal/goal_suggestion.dart';
import 'package:app/vo/goal/intervention_goal.dart';

class Goals
{
  List<InterventionGoal> elements;
  Map<String, List<GoalSuggestion>> suggestions;

  Goals({ required this.elements, required this.suggestions });

  factory Goals.fromJson(Map<String, dynamic> json)
  {
    final rawSuggestions = json['suggestions'] as Map<String, dynamic>? ?? {};

    return Goals(
      elements: (json['elements'] as List<dynamic>? ?? []).map((item) => InterventionGoal.fromJson(item)).toList(),
      suggestions: rawSuggestions.map((key, value)
      {
        return MapEntry(key, (value as List<dynamic>).map((item) => GoalSuggestion.fromJson(item)).toList());
      }),
    );
  }

  Map<String, dynamic> toJson()
  {
    return { 'elements': elements.map((goal) => goal.toJson()).toList(),
             'suggestions': suggestions.map((key, value)
             {
              return MapEntry(key, value.map((suggestion) => suggestion.toJson()).toList());
             }) };
  }
}
