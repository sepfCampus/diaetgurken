class DiagnosisSuggestionCondition
{
  String fieldName;
  String operator;
  dynamic compareValue;

  DiagnosisSuggestionCondition({ required this.fieldName, required this.operator,
                                 required this.compareValue });

  factory DiagnosisSuggestionCondition.fromJson(Map<String, dynamic> json)
  {
    return DiagnosisSuggestionCondition(fieldName: json['fieldName'], operator: json['operator'], compareValue: json['compareValue']);
  }
}
