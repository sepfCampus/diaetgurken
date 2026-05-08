enum FormElementType
{
  SELECTION("Selection"),
  TRUE_FALSE("True/False"),
  TEXT("Text"),
  NUMBER("Number"),
  DATE("Date");

  final String name;

  const FormElementType(this.name);

  static FormElementType getType(String name)
  {
    return FormElementType.values.firstWhere((type) => type.name == name, orElse: () => throw "Invalid type name");
  }
}
