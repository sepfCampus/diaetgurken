class SubGoal
{
  String text;

  SubGoal({ this.text = '' });

  factory SubGoal.fromJson(Map<String, dynamic> json)
  {
    return SubGoal(text: json['text'] ?? '');
  }

  Map<String, dynamic> toJson()
  {
    return { 'text': text };
  }
}
