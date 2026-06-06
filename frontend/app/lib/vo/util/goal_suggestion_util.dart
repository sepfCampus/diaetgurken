import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/goal/goal_suggestion.dart';
import 'package:app/vo/goal/goal_suggestion_condition.dart';

class GoalSuggestionUtil
{
  static double? _toNumber(dynamic value)
  {
    if(value == null)
    {
      return null;
    }

    if(value is num)
    {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }

  static bool _matchesCondition(dynamic actualValue, GoalSuggestionCondition condition)
  {
    final compareValue = condition.compareValue;

    switch(condition.operator)
    {
      case '=': return actualValue == compareValue;
      case '!=': return actualValue != compareValue;
      case '<':
      case '>':
      case '<=':
      case '>=':
        final actualNumber = _toNumber(actualValue);
        final compareNumber = _toNumber(compareValue);

        if(actualNumber == null || compareNumber == null) {
          return false;
        }

        switch(condition.operator)
        {
          case '<': return actualNumber < compareNumber;
          case '>': return actualNumber > compareNumber;
          case '<=': return actualNumber <= compareNumber;
          case '>=': return actualNumber >= compareNumber;
        }
    }

    return false;
  }

  static bool shouldShowSuggestion(GoalSuggestion suggestion, Assessment assessment)
  {
    for(final condition in suggestion.conditions)
    {
      final actualValue = assessment.getValue(condition.fieldName);

      if(assessment.hasAnswer(condition.fieldName) && _matchesCondition(actualValue, condition))
      {
        return true;
      }
    }

    return false;
  }

  static List<String> getSuggestionsToShow(List<GoalSuggestion> suggestions, Assessment assessment)
  {
    return suggestions.where((suggestion)
    {
      return shouldShowSuggestion(suggestion, assessment);
    }).map((suggestion) => suggestion.suggestedValue).toList();
  }
}
