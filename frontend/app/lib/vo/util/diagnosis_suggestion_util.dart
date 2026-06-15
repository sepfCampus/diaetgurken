import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/diagnosis/diagnosis_suggestion.dart';
import 'package:app/vo/diagnosis/diagnosis_suggestion_condition.dart';

class DiagnosisSuggestionUtil
{
  static double _toNumber(dynamic value)
  {
    if(value is num)
    {
      return value.toDouble();
    }

    return double.tryParse(value.toString()) ?? 0;
  }

  static bool _matchesCondition(dynamic actualValue, DiagnosisSuggestionCondition condition)
  {
    final compareValue = condition.compareValue;

    switch(condition.operator)
    {
      case '=': return actualValue == compareValue;
      case '!=': return actualValue != compareValue;
      case '<': return _toNumber(actualValue) < _toNumber(compareValue);
      case '>': return _toNumber(actualValue) > _toNumber(compareValue);
      case '<=': return _toNumber(actualValue) <= _toNumber(compareValue);
      case '>=': return _toNumber(actualValue) >= _toNumber(compareValue);
      default: return false;
    }
  }

  static bool shouldShowSuggestion(DiagnosisSuggestion suggestion, Assessment assessment)
  {
    if(suggestion.conditions.isEmpty)
    {
      return true;
    }

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

  static List<String> getSuggestionsToShow(List<DiagnosisSuggestion> suggestions, Assessment assessment)
  {
    return suggestions.where((suggestion) => shouldShowSuggestion(suggestion, assessment)).map((suggestion) => suggestion.suggestedValue).toList();
  }
}
