//states what cateogry an assessment input field belongs to
enum FormElementCategory
{
  body('body'),
  activity('activity'),
  participation('participation'),
  environment('environment'),
  personal('personal');

  final String name;

  const FormElementCategory(this.name);

  static FormElementCategory fromName(String name)
  {
    return FormElementCategory.values.firstWhere((category) => category.name == name,
                                                 orElse: () => throw Exception('Unknown form element category: $name'));
  }
}
