class ClientFileSummary
{
  final String summary;
  final String development;
  final List<String> currentGoals;
  final List<String> openPoints;
  final bool reviewRequired;

  const ClientFileSummary({
    required this.summary,
    required this.development,
    required this.currentGoals,
    required this.openPoints,
    required this.reviewRequired,
  });

  factory ClientFileSummary.fromJson(Map<String, dynamic> json)
  {
    final content = json['summary'] as Map<String, dynamic>;

    return ClientFileSummary(
      summary: content['summary'] as String,
      development: content['development'] as String,
      currentGoals: List<String>.from(content['currentGoals'] as List),
      openPoints: List<String>.from(content['openPoints'] as List),
      reviewRequired: json['reviewRequired'] as bool,
    );
  }
}
