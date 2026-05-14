import 'package:app/vo/outcome/outcome_goal.dart';

class Outcome
{
  List<OutcomeGoal> elements;

  Outcome({ required this.elements });

  factory Outcome.fromJson(Map<String, dynamic> json)
  {
    return Outcome(elements: (json['elements'] as List<dynamic>? ?? []).map((item) => OutcomeGoal.fromJson(item)).toList());
  }

  Map<String, dynamic> toJson()
  {
    return { 'elements': elements.map((goal) => goal.toJson()).toList() };
  }
}
