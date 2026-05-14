class DiagnosisElement
{
  String problem;
  String etiology;
  String signsAndSymptoms;
  String foerderfaktoren;
  String barrieren;

  DiagnosisElement({ this.problem = '', this.etiology = '', this.signsAndSymptoms = '',
                     this.foerderfaktoren = '', this.barrieren = '' });

  factory DiagnosisElement.fromJson(Map<String, dynamic> json)
  {
    return DiagnosisElement( problem: json['problem'] ?? '', etiology: json['etiology'] ?? '',
                             signsAndSymptoms: json['signsAndSymptoms'] ?? '', foerderfaktoren: json['foerderfaktoren'] ?? '',
                             barrieren: json['barrieren'] ?? '');
  }

  Map<String, dynamic> toJson()
  {
    return { 'problem': problem, 'etiology': etiology,
             'signsAndSymptoms': signsAndSymptoms, 'foerderfaktoren': foerderfaktoren,
             'barrieren': barrieren };
  }
}
