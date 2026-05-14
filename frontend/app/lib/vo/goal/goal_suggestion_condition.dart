class GoalSuggestionCondition
{
  String fieldName;
  String operator;
  dynamic compareValue;

  GoalSuggestionCondition({ required this.fieldName, required this.operator, required this.compareValue });

  factory GoalSuggestionCondition.fromJson(Map<String, dynamic> json)
  {
    return GoalSuggestionCondition(fieldName: json['fieldName'], operator: json['operator'], compareValue: json['compareValue']);
  }

  Map<String, dynamic> toJson()
  {
    return { 'fieldName': fieldName, 'operator': operator, 'compareValue': compareValue };
  }
}
