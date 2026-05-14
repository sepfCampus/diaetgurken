//THIS CLASS IS JUST A MOCK WHICH DOES NOT
//FOLLOW THE ARCHITECTURE FOR THE APP FULLY
//IT IS ONLY INTENDED FOR A SPECIFIC TEST CASE
//AND WILL BE DELETED LATER

//DO NOT USE AS INSPIRATION!!!

import 'dart:async';
import 'dart:convert';

class MockConversationRepository
{
  static Future<List<Map<String, dynamic>>> getConversationsForClient(String clientId,) async
  {
    await Future.delayed(const Duration(milliseconds: 700));

    const mockJson = '''
    [
      {
        "datum": "2026-01-01",
        "formMetaData": {
          "elements": [
            {
              "type": "Number",
              "name": "height",
              "displayName": "Größe (cm)",
              "defaultValue": 185,
              "isInteger": true,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Number",
              "name": "weight",
              "displayName": "Gewicht (kg)",
              "defaultValue": 104.2,
              "isInteger": false,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Number",
              "name": "waistCircumference",
              "displayName": "Taillenumfang (cm)",
              "defaultValue": 112,
              "isInteger": true,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Selection",
              "name": "activityLevel",
              "displayName": "Aktivitätslevel",
              "multipleSelection": false,
              "category": "activity",
              "filterOptions": ["overweight", "obesity"],
              "options": [
                { "name": "low", "text": "Niedrig", "selected": true },
                { "name": "medium", "text": "Mittel", "selected": false },
                { "name": "high", "text": "Hoch", "selected": false }
              ]
            },
            {
              "type": "Selection",
              "name": "stressLevel",
              "displayName": "Stresslevel",
              "multipleSelection": false,
              "category": "personal",
              "filterOptions": ["overweight", "obesity"],
              "options": [
                { "name": "low", "text": "Niedrig", "selected": false },
                { "name": "medium", "text": "Mittel", "selected": false },
                { "name": "high", "text": "Hoch", "selected": true }
              ]
            },
            {
              "type": "True/False",
              "name": "familySupport",
              "displayName": "Familiäre Unterstützung vorhanden",
              "defaultValue": true,
              "category": "environment",
              "filterOptions": ["overweight", "obesity"]
            }
          ]
        },
        "assessment": {
          "elements": [
            { "fieldName": "height", "value": 185 },
            { "fieldName": "weight", "value": 104.2 },
            { "fieldName": "waistCircumference", "value": 112 },
            { "fieldName": "activityLevel", "value": "low" },
            { "fieldName": "stressLevel", "value": "high" },
            { "fieldName": "familySupport", "value": true }
          ]
        },
        "diagnosen": {
          "elements": [
            {
              "problem": "Adipositas",
              "etiology": "langfristig erhöhte Energieaufnahme bei geringer körperlicher Aktivität",
              "signsAndSymptoms": "Gewicht 104.2 kg, Taillenumfang 112 cm, niedriges Aktivitätslevel",
              "foerderfaktoren": "familiäre Unterstützung vorhanden",
              "barrieren": "hohes Stresslevel und geringe Alltagsbewegung"
            }
          ],
          "suggestions": {
            "problem": [
              {
                "suggestedValue": "Adipositas",
                "conditions": [
                  { "fieldName": "weight", "operator": ">=", "compareValue": 100 }
                ]
              },
              {
                "suggestedValue": "Erhöhtes Risiko für ernährungsbedingte Folgeerkrankungen",
                "conditions": [
                  { "fieldName": "waistCircumference", "operator": ">=", "compareValue": 102 }
                ]
              }
            ],
            "etiology": [
              {
                "suggestedValue": "langfristig erhöhte Energieaufnahme",
                "conditions": []
              },
              {
                "suggestedValue": "geringe körperliche Aktivität",
                "conditions": [
                  { "fieldName": "activityLevel", "operator": "=", "compareValue": "low" }
                ]
              }
            ],
            "signsAndSymptoms": [
              {
                "suggestedValue": "erhöhter Taillenumfang",
                "conditions": [
                  { "fieldName": "waistCircumference", "operator": ">=", "compareValue": 102 }
                ]
              },
              {
                "suggestedValue": "Gewicht über Zielbereich",
                "conditions": [
                  { "fieldName": "weight", "operator": ">=", "compareValue": 100 }
                ]
              }
            ],
            "foerderfaktoren": [
              {
                "suggestedValue": "familiäre Unterstützung vorhanden",
                "conditions": [
                  { "fieldName": "familySupport", "operator": "=", "compareValue": true }
                ]
              }
            ],
            "barrieren": [
              {
                "suggestedValue": "hohes Stresslevel",
                "conditions": [
                  { "fieldName": "stressLevel", "operator": "=", "compareValue": "high" }
                ]
              }
            ]
          }
        },
        "ziele": {
          "elements": [
            {
              "text": "Reduktion der Kalorienaufnahme",
              "handlungsziele": [
                { "text": "5 x in der Woche selbst kochen" },
                { "text": "Täglich 1 x Obst essen" }
              ],
              "massnahmenziele": [
                { "text": "Einkaufsliste für drei Tage vorbereiten" },
                { "text": "Portionsgrößen beim Abendessen besprechen" }
              ]
            },
            {
              "text": "Steigerung der Alltagsbewegung",
              "handlungsziele": [
                { "text": "3 x pro Woche 20 Minuten spazieren gehen" }
              ],
              "massnahmenziele": [
                { "text": "Fixe Spazierzeiten im Kalender eintragen" }
              ]
            }
          ],
          "suggestions": {
            "interventionsziele": [
              {
                "suggestedValue": "Reduktion der Kalorienaufnahme",
                "conditions": [
                  { "fieldName": "weight", "operator": ">=", "compareValue": 100 }
                ]
              },
              {
                "suggestedValue": "Steigerung der Alltagsbewegung",
                "conditions": [
                  { "fieldName": "activityLevel", "operator": "=", "compareValue": "low" }
                ]
              }
            ],
            "handlungsziele": [
              {
                "suggestedValue": "5 x in der Woche selbst kochen",
                "conditions": []
              },
              {
                "suggestedValue": "Täglich 1 x Obst essen",
                "conditions": []
              },
              {
                "suggestedValue": "3 x pro Woche 20 Minuten spazieren gehen",
                "conditions": [
                  { "fieldName": "activityLevel", "operator": "=", "compareValue": "low" }
                ]
              }
            ],
            "massnahmenziele": [
              {
                "suggestedValue": "Einkaufsliste für drei Tage vorbereiten",
                "conditions": []
              },
              {
                "suggestedValue": "Portionsgrößen beim Abendessen besprechen",
                "conditions": []
              },
              {
                "suggestedValue": "Fixe Spazierzeiten im Kalender eintragen",
                "conditions": []
              }
            ]
          }
        },
        "outcome": {
          "elements": []
        },
        "notizen": "Erstgespräch: Fokus auf Gewicht, Essstruktur, Alltagsbewegung und Stress."
      },

      {
        "datum": "2026-01-14",
        "formMetaData": {
          "elements": [
            {
              "type": "Number",
              "name": "height",
              "displayName": "Größe (cm)",
              "defaultValue": 185,
              "isInteger": true,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Number",
              "name": "weight",
              "displayName": "Gewicht (kg)",
              "defaultValue": 101.8,
              "isInteger": false,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Number",
              "name": "waistCircumference",
              "displayName": "Taillenumfang (cm)",
              "defaultValue": 109,
              "isInteger": true,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Selection",
              "name": "activityLevel",
              "displayName": "Aktivitätslevel",
              "multipleSelection": false,
              "category": "activity",
              "filterOptions": ["overweight", "obesity"],
              "options": [
                { "name": "low", "text": "Niedrig", "selected": false },
                { "name": "medium", "text": "Mittel", "selected": true },
                { "name": "high", "text": "Hoch", "selected": false }
              ]
            },
            {
              "type": "Selection",
              "name": "stressLevel",
              "displayName": "Stresslevel",
              "multipleSelection": false,
              "category": "personal",
              "filterOptions": ["overweight", "obesity"],
              "options": [
                { "name": "low", "text": "Niedrig", "selected": false },
                { "name": "medium", "text": "Mittel", "selected": true },
                { "name": "high", "text": "Hoch", "selected": false }
              ]
            },
            {
              "type": "True/False",
              "name": "familySupport",
              "displayName": "Familiäre Unterstützung vorhanden",
              "defaultValue": true,
              "category": "environment",
              "filterOptions": ["overweight", "obesity"]
            }
          ]
        },
        "assessment": {
          "elements": [
            { "fieldName": "height", "value": 185 },
            { "fieldName": "weight", "value": 101.8 },
            { "fieldName": "waistCircumference", "value": 109 },
            { "fieldName": "activityLevel", "value": "medium" },
            { "fieldName": "stressLevel", "value": "medium" },
            { "fieldName": "familySupport", "value": true }
          ]
        },
        "diagnosen": {
          "elements": [
            {
              "problem": "Adipositas mit beginnender Verhaltensänderung",
              "etiology": "Energieaufnahme noch erhöht, Aktivität jedoch bereits verbessert",
              "signsAndSymptoms": "Gewicht 101.8 kg, Taillenumfang 109 cm",
              "foerderfaktoren": "regelmäßiges Kochen und familiäre Unterstützung",
              "barrieren": "Stresssituationen am Abend"
            }
          ],
          "suggestions": {
            "problem": [
              {
                "suggestedValue": "Adipositas mit beginnender Verhaltensänderung",
                "conditions": [
                  { "fieldName": "weight", "operator": ">=", "compareValue": 100 }
                ]
              }
            ],
            "etiology": [
              {
                "suggestedValue": "Energieaufnahme noch erhöht",
                "conditions": []
              }
            ],
            "signsAndSymptoms": [
              {
                "suggestedValue": "Taillenumfang weiterhin erhöht",
                "conditions": [
                  { "fieldName": "waistCircumference", "operator": ">=", "compareValue": 102 }
                ]
              }
            ],
            "foerderfaktoren": [
              {
                "suggestedValue": "erste erfolgreiche Umsetzung im Alltag",
                "conditions": []
              }
            ],
            "barrieren": [
              {
                "suggestedValue": "Stresssituationen am Abend",
                "conditions": [
                  { "fieldName": "stressLevel", "operator": "=", "compareValue": "medium" }
                ]
              }
            ]
          }
        },
        "ziele": {
          "elements": [
            {
              "text": "Stabilisierung der regelmäßigen Mahlzeitenstruktur",
              "handlungsziele": [
                { "text": "An 5 Tagen pro Woche ein geplantes Abendessen einhalten" },
                { "text": "Süße Snacks auf 2 geplante Portionen pro Woche begrenzen" }
              ],
              "massnahmenziele": [
                { "text": "Wochenplan mit drei einfachen Abendessen erstellen" },
                { "text": "Snackalternativen gemeinsam definieren" }
              ]
            },
            {
              "text": "Weitere Steigerung der Alltagsbewegung",
              "handlungsziele": [
                { "text": "4 x pro Woche 25 Minuten spazieren gehen" }
              ],
              "massnahmenziele": [
                { "text": "Spaziergänge direkt nach der Arbeit einplanen" }
              ]
            }
          ],
          "suggestions": {
            "interventionsziele": [
              {
                "suggestedValue": "Stabilisierung der regelmäßigen Mahlzeitenstruktur",
                "conditions": [
                  { "fieldName": "weight", "operator": ">=", "compareValue": 95 }
                ]
              },
              {
                "suggestedValue": "Weitere Steigerung der Alltagsbewegung",
                "conditions": [
                  { "fieldName": "activityLevel", "operator": "=", "compareValue": "medium" }
                ]
              }
            ],
            "handlungsziele": [
              {
                "suggestedValue": "An 5 Tagen pro Woche ein geplantes Abendessen einhalten",
                "conditions": []
              },
              {
                "suggestedValue": "Süße Snacks auf 2 geplante Portionen pro Woche begrenzen",
                "conditions": []
              },
              {
                "suggestedValue": "4 x pro Woche 25 Minuten spazieren gehen",
                "conditions": []
              }
            ],
            "massnahmenziele": [
              {
                "suggestedValue": "Wochenplan mit drei einfachen Abendessen erstellen",
                "conditions": []
              },
              {
                "suggestedValue": "Snackalternativen gemeinsam definieren",
                "conditions": []
              },
              {
                "suggestedValue": "Spaziergänge direkt nach der Arbeit einplanen",
                "conditions": []
              }
            ]
          }
        },
        "outcome": {
          "elements": [
            {
              "text": "Reduktion der Kalorienaufnahme",
              "success": 70,
              "note": "Kochen klappt deutlich besser, Portionsgrößen sind aber abends noch schwierig.",
              "handlungsziele": [
                {
                  "text": "5 x in der Woche selbst kochen",
                  "success": 80,
                  "note": "In der letzten Woche 4 bis 5 Mal umgesetzt."
                },
                {
                  "text": "Täglich 1 x Obst essen",
                  "success": 65,
                  "note": "An den meisten Tagen umgesetzt, am Wochenende weniger regelmäßig."
                }
              ],
              "massnahmenziele": [
                {
                  "text": "Einkaufsliste für drei Tage vorbereiten",
                  "success": 75,
                  "note": "Hat geholfen, spontane Einkäufe zu reduzieren."
                },
                {
                  "text": "Portionsgrößen beim Abendessen besprechen",
                  "success": 55,
                  "note": "Besprochen, Umsetzung noch unsicher."
                }
              ]
            },
            {
              "text": "Steigerung der Alltagsbewegung",
              "success": 60,
              "note": "Spaziergänge wurden begonnen, aber noch nicht stabil.",
              "handlungsziele": [
                {
                  "text": "3 x pro Woche 20 Minuten spazieren gehen",
                  "success": 60,
                  "note": "Zwei Spaziergänge pro Woche waren realistisch."
                }
              ],
              "massnahmenziele": [
                {
                  "text": "Fixe Spazierzeiten im Kalender eintragen",
                  "success": 50,
                  "note": "Einträge wurden gemacht, aber nicht immer eingehalten."
                }
              ]
            }
          ]
        },
        "notizen": "Kontrolltermin: Gewicht rückläufig, Motivation stabil, Stress weiterhin Thema."
      },

      {
        "datum": "2026-02-20",
        "formMetaData": {
          "elements": [
            {
              "type": "Number",
              "name": "height",
              "displayName": "Größe (cm)",
              "defaultValue": 185,
              "isInteger": true,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Number",
              "name": "weight",
              "displayName": "Gewicht (kg)",
              "defaultValue": 99.6,
              "isInteger": false,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Number",
              "name": "waistCircumference",
              "displayName": "Taillenumfang (cm)",
              "defaultValue": 106,
              "isInteger": true,
              "category": "body",
              "filterOptions": ["overweight", "obesity"]
            },
            {
              "type": "Selection",
              "name": "activityLevel",
              "displayName": "Aktivitätslevel",
              "multipleSelection": false,
              "category": "activity",
              "filterOptions": ["overweight", "obesity"],
              "options": [
                { "name": "low", "text": "Niedrig", "selected": false },
                { "name": "medium", "text": "Mittel", "selected": true },
                { "name": "high", "text": "Hoch", "selected": false }
              ]
            },
            {
              "type": "Selection",
              "name": "stressLevel",
              "displayName": "Stresslevel",
              "multipleSelection": false,
              "category": "personal",
              "filterOptions": ["overweight", "obesity"],
              "options": [
                { "name": "low", "text": "Niedrig", "selected": false },
                { "name": "medium", "text": "Mittel", "selected": true },
                { "name": "high", "text": "Hoch", "selected": false }
              ]
            },
            {
              "type": "True/False",
              "name": "familySupport",
              "displayName": "Familiäre Unterstützung vorhanden",
              "defaultValue": true,
              "category": "environment",
              "filterOptions": ["overweight", "obesity"]
            }
          ]
        },
        "assessment": {
          "elements": [
            { "fieldName": "height", "value": 185 },
            { "fieldName": "weight", "value": 99.6 },
            { "fieldName": "waistCircumference", "value": 106 },
            { "fieldName": "activityLevel", "value": "medium" },
            { "fieldName": "stressLevel", "value": "medium" },
            { "fieldName": "familySupport", "value": true }
          ]
        },
        "diagnosen": {
          "elements": [
            {
              "problem": "Übergewicht mit verbessertem Ernährungsverhalten",
              "etiology": "Portionsgrößen und Snackverhalten weiterhin relevant",
              "signsAndSymptoms": "Gewicht 99.6 kg, Taillenumfang 106 cm",
              "foerderfaktoren": "regelmäßige Mahlzeitenplanung",
              "barrieren": "Wochenenden mit unstrukturierter Nahrungsaufnahme"
            }
          ],
          "suggestions": {
            "problem": [
              {
                "suggestedValue": "Übergewicht mit verbessertem Ernährungsverhalten",
                "conditions": [
                  { "fieldName": "weight", "operator": "<", "compareValue": 100 }
                ]
              }
            ],
            "etiology": [
              {
                "suggestedValue": "Portionsgrößen und Snackverhalten weiterhin relevant",
                "conditions": []
              }
            ],
            "signsAndSymptoms": [
              {
                "suggestedValue": "Taillenumfang weiterhin erhöht",
                "conditions": [
                  { "fieldName": "waistCircumference", "operator": ">=", "compareValue": 102 }
                ]
              }
            ],
            "foerderfaktoren": [
              {
                "suggestedValue": "regelmäßige Mahlzeitenplanung",
                "conditions": []
              }
            ],
            "barrieren": [
              {
                "suggestedValue": "Wochenenden mit unstrukturierter Nahrungsaufnahme",
                "conditions": []
              }
            ]
          }
        },
        "ziele": {
          "elements": [],
          "suggestions": {
            "interventionsziele": [
              {
                "suggestedValue": "Gewichtsstabilisierung unter 100 kg",
                "conditions": [
                  { "fieldName": "weight", "operator": "<", "compareValue": 100 }
                ]
              },
              {
                "suggestedValue": "Verbesserung der Wochenendstruktur",
                "conditions": [
                  { "fieldName": "stressLevel", "operator": "=", "compareValue": "medium" }
                ]
              }
            ],
            "handlungsziele": [
              {
                "suggestedValue": "Am Wochenende eine Hauptmahlzeit vorausplanen",
                "conditions": []
              },
              {
                "suggestedValue": "Gewicht 1 x pro Woche dokumentieren",
                "conditions": []
              }
            ],
            "massnahmenziele": [
              {
                "suggestedValue": "Wochenend-Notfallplan für Snacks erstellen",
                "conditions": []
              },
              {
                "suggestedValue": "Wiegeprotokoll anlegen",
                "conditions": []
              }
            ]
          }
        },
        "outcome": {
          "elements": [
            {
              "text": "Stabilisierung der regelmäßigen Mahlzeitenstruktur",
              "success": 75,
              "note": "Mahlzeitenstruktur ist deutlich regelmäßiger, Snacks bleiben Thema.",
              "handlungsziele": [
                {
                  "text": "An 5 Tagen pro Woche ein geplantes Abendessen einhalten",
                  "success": 80,
                  "note": "Unter der Woche sehr gut gelungen."
                },
                {
                  "text": "Süße Snacks auf 2 geplante Portionen pro Woche begrenzen",
                  "success": 55,
                  "note": "Teilweise umgesetzt, besonders am Wochenende schwierig."
                }
              ],
              "massnahmenziele": [
                {
                  "text": "Wochenplan mit drei einfachen Abendessen erstellen",
                  "success": 85,
                  "note": "Plan wurde genutzt und als hilfreich erlebt."
                },
                {
                  "text": "Snackalternativen gemeinsam definieren",
                  "success": 60,
                  "note": "Alternativen bekannt, aber noch nicht automatisch umgesetzt."
                }
              ]
            },
            {
              "text": "Weitere Steigerung der Alltagsbewegung",
              "success": 65,
              "note": "Bewegung leicht gesteigert, aber noch ausbaufähig.",
              "handlungsziele": [
                {
                  "text": "4 x pro Woche 25 Minuten spazieren gehen",
                  "success": 60,
                  "note": "Meist 3 Spaziergänge pro Woche erreicht."
                }
              ],
              "massnahmenziele": [
                {
                  "text": "Spaziergänge direkt nach der Arbeit einplanen",
                  "success": 70,
                  "note": "Nach der Arbeit funktioniert besser als am Abend."
                }
              ]
            }
          ]
        },
        "notizen": "Verlauf positiv. Fokus nächstes Mal: Wochenendstruktur und Gewichtsstabilisierung."
      }
    ]
    ''';

    final decoded = jsonDecode(mockJson) as List<dynamic>;

    return decoded.map((conversation) => conversation as Map<String, dynamic>).toList();
  }

  static Map<String, dynamic> _createOutcomeFromPreviousGoals(Map<String, dynamic> previousGoals)
  {
    final rawInterventionGoals = previousGoals['elements'] as List<dynamic>? ?? [];

    return
    {
      'elements': rawInterventionGoals.map((goal)
      {
        return
        {
          'text': goal['text'] ?? '',
          'success': 50,
          'note': '',

          'handlungsziele': (goal['handlungsziele'] as List<dynamic>? ?? []).map((subGoal)
          {
            return
            {
              'text': subGoal['text'] ?? '',
              'success': 50,
              'note': '',
            };
          }).toList(),

          'massnahmenziele': (goal['massnahmenziele'] as List<dynamic>? ?? []).map((subGoal) {
            return
            {
              'text': subGoal['text'] ?? '',
              'success': 50,
              'note': '',
            };
          }).toList(),
        };
      }).toList(),
    };
  }

  static Map<String, dynamic> createConversation({ required List<Map<String, dynamic>> conversations, required String datum })
  {
    final sorted = [...conversations];

    sorted.sort((a, b)
    {
      final aDate = DateTime.parse(a['datum']);
      final bDate = DateTime.parse(b['datum']);
      return bDate.compareTo(aDate);
    });

    final Map<String, dynamic>? lastConversation = sorted.isEmpty ? null : sorted.first;

    final Map<String, dynamic> lastGoals = lastConversation?['ziele'] as Map<String, dynamic>? ?? { 'elements': [] };

    return
    {
      'datum': datum,

      'formMetaData':
      {
        'elements': [],
      },

      'assessment':
      {
        'elements': [],
      },

      'diagnosen':
      {
        'elements': [],
        'suggestions':
        {
          'problem': [],
          'etiology': [],
          'signsAndSymptoms': [],
          'foerderfaktoren': [],
          'barrieren': [],
        },
      },

      'ziele':
      {
        'elements': [],
        'suggestions':
        {
          'interventionsziele': [],
          'handlungsziele': [],
          'massnahmenziele': [],
        },
      },

      'outcome': _createOutcomeFromPreviousGoals(lastGoals),

      'notizen': '',
    };
  }
}

//THIS CLASS IS JUST A MOCK WHICH DOES NOT
//FOLLOW THE ARCHITECTURE FOR THE APP FULLY
//IT IS ONLY INTENDED FOR A SPECIFIC TEST CASE
//AND WILL BE DELETED LATER

//DO NOT USE AS INSPIRATION!!!
