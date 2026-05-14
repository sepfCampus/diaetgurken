class OutcomeSubGoal
{
  String text;
  double success;
  String note;

  OutcomeSubGoal({ this.text = '', this.success = 50, this.note = '' });

  factory OutcomeSubGoal.fromJson(Map<String, dynamic> json)
  {
    return OutcomeSubGoal(text: json['text'] ?? '', success: (json['success'] as num?)?.toDouble() ?? 50, note: json['note'] ?? '');
  }

  Map<String, dynamic> toJson()
  {
    return { 'text': text, 'success': success, 'note': note };
  }
}
