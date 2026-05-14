import 'package:app/vo/outcome/outcome_sub_goal.dart';

class OutcomeGoal
{
  String text;
  double success;
  String note;
  List<OutcomeSubGoal> handlungsziele;
  List<OutcomeSubGoal> massnahmenziele;

  OutcomeGoal({ this.text = '', this.success = 50, this.note = '', List<OutcomeSubGoal>? handlungsziele, List<OutcomeSubGoal>? massnahmenziele }) : handlungsziele = handlungsziele ?? [], massnahmenziele = massnahmenziele ?? [];

  factory OutcomeGoal.fromJson(Map<String, dynamic> json)
  {
    return OutcomeGoal( text: json['text'] ?? '', success: (json['success'] as num?)?.toDouble() ?? 50, note: json['note'] ?? '',
                        handlungsziele: (json['handlungsziele'] as List<dynamic>? ?? []).map((item) => OutcomeSubGoal.fromJson(item)).toList(),
                        massnahmenziele: (json['massnahmenziele'] as List<dynamic>? ?? []).map((item) => OutcomeSubGoal.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson()
  {
    return { 'text': text, 'success': success, 'note': note, 'handlungsziele': handlungsziele.map((goal) => goal.toJson()).toList(), 'massnahmenziele': massnahmenziele.map((goal) => goal.toJson()).toList() };
  }
}
