class AssessmentElement
{
  String fieldName;
  dynamic value;
  bool noAnswerProvided;

  AssessmentElement(this.fieldName, this.value, this.noAnswerProvided);

  factory AssessmentElement.fromJson(Map<String, dynamic> json)
  {
    return AssessmentElement(json['fieldName'], json['value'], json['noAnswerProvided'] ?? false);
  }

  Map<String, dynamic> toJson()
  {
    return { 'fieldName': fieldName, 'value': value, 'noAnswerProvided': noAnswerProvided };
  }
}
