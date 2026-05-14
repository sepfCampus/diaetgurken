import 'package:app/vo/goal/sub_goal.dart';

class InterventionGoal
{
  String text;
  List<SubGoal> handlungsziele;
  List<SubGoal> massnahmenziele;

  InterventionGoal({ this.text = '', List<SubGoal>? handlungsziele, List<SubGoal>? massnahmenziele }) : handlungsziele = handlungsziele ?? [], massnahmenziele = massnahmenziele ?? [];

  factory InterventionGoal.fromJson(Map<String, dynamic> json)
  {
    return InterventionGoal(text: json['text'] ?? '',
                            handlungsziele: (json['handlungsziele'] as List<dynamic>? ?? []).map((item) => SubGoal.fromJson(item)).toList(),
                            massnahmenziele: (json['massnahmenziele'] as List<dynamic>? ?? []).map((item) => SubGoal.fromJson(item)).toList());
  }

  Map<String, dynamic> toJson()
  {
    return { 'text': text, 'handlungsziele': handlungsziele.map((goal) => goal.toJson()).toList(),
             'massnahmenziele': massnahmenziele.map((goal) => goal.toJson()).toList()};
  }
}
