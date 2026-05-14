class AssessmentElement
{
  String fieldName;
  dynamic value;

  AssessmentElement(this.fieldName, this.value);

  factory AssessmentElement.fromJson(Map<String, dynamic> json)
  {
    return AssessmentElement(json['fieldName'], json['value']);
  }

  Map<String, dynamic> toJson()
  {
    return { 'fieldName': fieldName, 'value': value };
  }
}
