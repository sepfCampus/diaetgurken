import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/diagnosis/diagnosis.dart';
import 'package:app/vo/form/form_meta_data.dart';
import 'package:app/vo/goal/goals.dart';
import 'package:app/vo/outcome/outcome.dart';
import 'package:app/vo/util/date_util.dart';

class ConversationCreator
{
  static Conversation createDefaultConversation({ FormMetaData? formMetaData, Assessment? assessment, Diagnosis? diagnosis, Goals? goals, Outcome? outcome, String? notes, List<String>? selectedFilters })
  {
    FormMetaData defaultFormMetaData = new FormMetaData.fromJson(
      {
        'elements':
        [
          {
            'type': 'Number',
            'name': 'height',
            'displayName': 'Größe / Länge (cm)',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'weight',
            'displayName': 'Gewicht (kg)',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'bmi',
            'displayName': 'BMI',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'weightHistory',
            'displayName': 'Gewichtsverlauf',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'waistCircumference',
            'displayName': 'Taillenumfang (cm)',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'waistHipRatio',
            'displayName': 'Taille-Hüfte-Verhältnis',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'labValues',
            'displayName': 'Labordaten',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'medicalDiagnosticResults',
            'displayName': 'Ergebnisse medizinischer Diagnostik / Tests',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'anthropometricData',
            'displayName': 'Anthropometrische Daten inkl. BCM',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'handGripStrength',
            'displayName': 'Handkraft',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'physicalActivity',
            'displayName': 'Körperliche Aktivität',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'diseaseRelevantLimitations',
            'displayName': 'Einschränkungen betreffend Krankheit / Funktionen',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'bodyImage',
            'displayName': 'Eigenes Körperbild',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'chewing',
            'displayName': 'Kauen',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'oralStatus',
            'displayName': 'Oraler Status inkl. Zahnstatus',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'swallowing',
            'displayName': 'Schlucken',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'breathing',
            'displayName': 'Atmen',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'gastrointestinalProblems',
            'displayName': 'Gastrointestinale Probleme',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'mentalFunctionsRelatedToNutrition',
            'displayName': 'Mentale Funktionen, die sich auf die Ernährung auswirken',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'appetite',
            'displayName': 'Appetit',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'motivation',
            'displayName': 'Motivation / Bedürfnis zu essen',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'smellAndTaste',
            'displayName': 'Geruchs- und Geschmackssinn',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'anxietyAversionSadness',
            'displayName': 'Angst, Aversion und Trauergefühle',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'personality',
            'displayName': 'Persönlichkeit',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'motivationToAct',
            'displayName': 'Motivation / Mut zum Handeln',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'energyNeeds',
            'displayName': 'Energiebedarf',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'proteinNeeds',
            'displayName': 'Eiweißbedarf',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'waterNeeds',
            'displayName': 'Wasserbedarf',
            'defaultValue': null,
            'isInteger': false,
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'electrolyteNeeds',
            'displayName': 'Elektrolytbedarf',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'nutrientNeeds',
            'displayName': 'Nährstoffbedarf',
            'defaultValue': '',
            'category': 'body',
            'filterOptions': ["Übergewicht"],
          },

          {
            'type': 'Text',
            'name': 'dailyProceduresPlanning',
            'displayName': 'Alltägliche Prozeduren planen und ausführen',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'nutritionRelation',
            'displayName': 'Bezug zur Ernährung haben',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'stressManagement',
            'displayName': 'Mit Stress umgehen',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'communication',
            'displayName': 'Kommunizieren mittels Sprache, Zeichen und Symbolen',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'communicationTechniques',
            'displayName': 'Kommunikationstechniken und -geräte nutzen',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'mobility',
            'displayName': 'Mobilität',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'nutritionAndFluidIntake',
            'displayName': 'Nahrungs-, Flüssigkeits- und Nährstoffaufnahme',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Number',
            'name': 'mealFrequency',
            'displayName': 'Mahlzeitenfrequenz',
            'defaultValue': null,
            'isInteger': true,
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'coordinatedHandling',
            'displayName': 'Koordinierte Handlungen / Aufgaben durchführen',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'eatingServedFood',
            'displayName': 'Essen servierter Speisen',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'drinkingLiquids',
            'displayName': 'Trinken von Flüssigkeiten',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'healthAwareness',
            'displayName': 'Auf eigene Gesundheit achten',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'movementBehaviorAtWorkAndLeisure',
            'displayName': 'Bewegungsverhalten im Berufsalltag und in der Freizeit',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'professionalActivities',
            'displayName': 'Berufliche Aktivitäten',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'mealPreparation',
            'displayName': 'Mahlzeiten vorbereiten',
            'defaultValue': '',
            'category': 'activity',
            'filterOptions': ["Übergewicht"],
          },

          {
            'type': 'Text',
            'name': 'relationships',
            'displayName': 'Beziehung aufnehmen und aufrecht erhalten',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'socialNetworks',
            'displayName': 'Soziale Netzwerke nutzen',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'educationParticipation',
            'displayName': 'Beteiligung an Bildungs- / Ausbildungsprogrammen',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'workSearchAndWorkBehavior',
            'displayName': 'Arbeit suchen, Arbeitsverhältnis behalten',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'paidUnpaidWork',
            'displayName': 'Bezahlte / unbezahlte Tätigkeit',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'economicIndependence',
            'displayName': 'Wirtschaftliche Eigenständigkeit',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'communityLifeParticipation',
            'displayName': 'Beteiligung am gemeinschaftlichen sozialen Leben',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'sportsArtCulture',
            'displayName': 'Beteiligung an Sport, Kunst und Kultur',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'customersAndHobbies',
            'displayName': 'Kundenverkehr und Hobbys',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'religiousAndSpiritualEvents',
            'displayName': 'Beteiligung an religiösen und spirituellen Veranstaltungen',
            'defaultValue': '',
            'category': 'participation',
            'filterOptions': ["Übergewicht"],
          },

          {
            'type': 'Text',
            'name': 'accessToSafeDrinkingWater',
            'displayName': 'Zugang zu sicherem Trinkwasser',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'accessToHealthPromotingFood',
            'displayName': 'Zugang zu sicheren / gesundheitsfördernden Lebensmitteln',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'oralSupplements',
            'displayName': 'Orale Supplemente',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'enteralParenteralNutrition',
            'displayName': 'Trinknahrung, enterale / parenterale Nahrung',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'availabilityOfProsthesesAndAssistiveDevices',
            'displayName': 'Verfügbarkeit von Prothesen und Hilfsmitteln',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'workplace',
            'displayName': 'Arbeitsplatz',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'financialResources',
            'displayName': 'Vermögenswerte',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'housingSituation',
            'displayName': 'Wohnsituation',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'schoolSituation',
            'displayName': 'Schulsituation',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'transportOptions',
            'displayName': 'Transportmöglichkeiten',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'supportByFamilyAndSocialNetwork',
            'displayName': 'Unterstützung durch Familie, Freundeskreis, Bekannte und Nachbarn',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'healthSystemProfessionals',
            'displayName': 'Fachleute des Gesundheitssystems und deren Einstellungen',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'pets',
            'displayName': 'Haustiere',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'societalAttitudesAndNorms',
            'displayName': 'Gesellschaftliche Einstellungen, Normen und Konventionen',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'healthInsuranceConditions',
            'displayName': 'Rahmenbedingungen der Krankenversicherung',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'legalConditions',
            'displayName': 'Gesetzliche Rahmenbedingungen',
            'defaultValue': '',
            'category': 'environment',
            'filterOptions': ["Übergewicht"],
          },

          {
            'type': 'Number',
            'name': 'age',
            'displayName': 'Alter',
            'defaultValue': null,
            'isInteger': true,
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'gender',
            'displayName': 'Geschlecht',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'ethnicOrigin',
            'displayName': 'Ethnische Herkunft',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'geneticPredisposition',
            'displayName': 'Genetische Prädisposition',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'familyStatus',
            'displayName': 'Familienstand',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'languageCompetence',
            'displayName': 'Sprachkompetenz / Muttersprache',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'socialCulturalBackground',
            'displayName': 'Sozialer / kultureller Hintergrund',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'religion',
            'displayName': 'Religion',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'socialEconomicStatus',
            'displayName': 'Sozioökonomischer Status',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'education',
            'displayName': 'Bildung / Ausbildung',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'profession',
            'displayName': 'Beruf',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'interests',
            'displayName': 'Interessen',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'attitudesBeliefsExpectations',
            'displayName': 'Einstellungen, Überzeugungen, Vorstellungen, Erwartungen',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'motivationForBehaviorChange',
            'displayName': 'Motivation zur Verhaltensänderung',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'dietHistory',
            'displayName': 'Diäthistorie',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'weightHistoryPersonal',
            'displayName': 'Gewichtshistorie',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'comorbidity',
            'displayName': 'Komorbidität',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'personalEffectiveness',
            'displayName': 'Persönliche Effektivität',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'copingWithDisabilityDiseaseRestriction',
            'displayName': 'Bewältigungsverhalten im Umgang mit Behinderung / Erkrankung / Einschränkung',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'lifestyle',
            'displayName': 'Lebensstil',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'True/False',
            'name': 'smoking',
            'displayName': 'Rauchen',
            'defaultValue': false,
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'True/False',
            'name': 'alcoholUse',
            'displayName': 'Alkoholgebrauch',
            'defaultValue': false,
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'preferences',
            'displayName': 'Vorlieben',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'eatingBiography',
            'displayName': 'Essbiografie',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'generalPhysicalCondition',
            'displayName': 'Körperkondition im Allgemeinen',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'loneliness',
            'displayName': 'Einsamkeit',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'knowledge',
            'displayName': 'Wissen',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'adherence',
            'displayName': 'Adhärenz',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          },
          {
            'type': 'Text',
            'name': 'qualityOfLife',
            'displayName': 'Lebensqualität',
            'defaultValue': '',
            'category': 'personal',
            'filterOptions': ["Übergewicht"],
          }
        ]
      }
    );

    Diagnosis defaultDiagnosis = Diagnosis.fromJson(
      {
        'elements': [],

        'suggestions':
        {
          'problem':
          [
            {
              'suggestedValue': 'Erhöhtes Körpergewicht / Adipositas',
              'conditions':
              [
                { 'fieldName': 'bmi', 'operator': '>=', 'compareValue': 30 }
              ]
            },
            {
              'suggestedValue': 'Übergewicht',
              'conditions':
              [
                { 'fieldName': 'bmi', 'operator': '>=', 'compareValue': 25 },
                { 'fieldName': 'bmi', 'operator': '<', 'compareValue': 30 }
              ]
            },
            {
              'suggestedValue': 'Erhöhter Taillenumfang',
              'conditions':
              [
                { 'fieldName': 'waistCircumference', 'operator': '>=', 'compareValue': 102 }
              ]
            },
            {
              'suggestedValue': 'Unregelmäßige Mahlzeitenstruktur',
              'conditions':
              [
                { 'fieldName': 'mealFrequency', 'operator': '<', 'compareValue': 3 }
              ]
            },
            {
              'suggestedValue': 'Geringe körperliche Aktivität',
              'conditions':
              [
                { 'fieldName': 'physicalActivity', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Eingeschränkte Nahrungs- und Flüssigkeitsaufnahme',
              'conditions':
              [
                { 'fieldName': 'nutritionAndFluidIntake', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Kau- oder Schluckproblematik',
              'conditions':
              [
                { 'fieldName': 'chewing', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Gastrointestinale Beschwerden mit Einfluss auf die Ernährung',
              'conditions':
              [
                { 'fieldName': 'gastrointestinalProblems', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Eingeschränkte Fähigkeit zur Mahlzeitenvorbereitung',
              'conditions':
              [
                { 'fieldName': 'mealPreparation', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Eingeschränkter Zugang zu geeigneten Lebensmitteln',
              'conditions':
              [
                { 'fieldName': 'accessToHealthPromotingFood', 'operator': '!=', 'compareValue': '' }
              ]
            },
          ],

          'etiology':
          [
            {
              'suggestedValue': 'bedingt durch langfristig erhöhte Energieaufnahme',
              'conditions':
              [
                { 'fieldName': 'bmi', 'operator': '>=', 'compareValue': 25 }
              ]
            },
            {
              'suggestedValue': 'bedingt durch geringe körperliche Aktivität',
              'conditions':
              [
                { 'fieldName': 'physicalActivity', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'bedingt durch unregelmäßige Mahlzeitenfrequenz',
              'conditions':
              [
                { 'fieldName': 'mealFrequency', 'operator': '<', 'compareValue': 3 }
              ]
            },
            {
              'suggestedValue': 'bedingt durch Stress im Alltag',
              'conditions':
              [
                { 'fieldName': 'stressManagement', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'bedingt durch eingeschränkte Mobilität',
              'conditions':
              [
                { 'fieldName': 'mobility', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'bedingt durch Kauprobleme',
              'conditions':
              [
                { 'fieldName': 'chewing', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'bedingt durch Schluckprobleme',
              'conditions':
              [
                { 'fieldName': 'swallowing', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'bedingt durch eingeschränkten Zugang zu sicheren Lebensmitteln',
              'conditions':
              [
                { 'fieldName': 'accessToHealthPromotingFood', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'bedingt durch finanzielle oder organisatorische Barrieren',
              'conditions':
              [
                { 'fieldName': 'financialResources', 'operator': '!=', 'compareValue': '' }
              ]
            },
          ],

          'signsAndSymptoms':
          [
            {
              'suggestedValue': 'BMI oberhalb des Zielbereichs',
              'conditions':
              [
                { 'fieldName': 'bmi', 'operator': '>=', 'compareValue': 25 }
              ]
            },
            {
              'suggestedValue': 'Taillenumfang erhöht',
              'conditions':
              [
                { 'fieldName': 'waistCircumference', 'operator': '>=', 'compareValue': 102 }
              ]
            },
            {
              'suggestedValue': 'Gewichtsverlauf auffällig',
              'conditions':
              [
                { 'fieldName': 'weightHistory', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Laborwerte auffällig',
              'conditions':
              [
                { 'fieldName': 'labValues', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'reduzierte Mahlzeitenfrequenz',
              'conditions':
              [
                { 'fieldName': 'mealFrequency', 'operator': '<', 'compareValue': 3 }
              ]
            },
            {
              'suggestedValue': 'eingeschränkte Mahlzeitenvorbereitung',
              'conditions':
              [
                { 'fieldName': 'mealPreparation', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'gastrointestinale Beschwerden berichtet',
              'conditions':
              [
                { 'fieldName': 'gastrointestinalProblems', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Kau- oder Schluckbeschwerden berichtet',
              'conditions':
              [
                { 'fieldName': 'chewing', 'operator': '!=', 'compareValue': '' }
              ]
            },
          ],

          'foerderfaktoren':
          [
            {
              'suggestedValue': 'familiäre oder soziale Unterstützung vorhanden',
              'conditions':
              [
                { 'fieldName': 'supportByFamilyAndSocialNetwork', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Motivation zur Verhaltensänderung vorhanden',
              'conditions':
              [
                { 'fieldName': 'motivationForBehaviorChange', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'ausreichendes Wissen vorhanden',
              'conditions':
              [
                { 'fieldName': 'knowledge', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Adhärenz vorhanden',
              'conditions':
              [
                { 'fieldName': 'adherence', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Zugang zu gesundheitsfördernden Lebensmitteln möglich',
              'conditions':
              [
                { 'fieldName': 'accessToHealthPromotingFood', 'operator': '!=', 'compareValue': '' }
              ]
            },
          ],

          'barrieren':
          [
            {
              'suggestedValue': 'Stress erschwert die Umsetzung',
              'conditions':
              [
                { 'fieldName': 'stressManagement', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'eingeschränkte Mobilität erschwert die Umsetzung',
              'conditions':
              [
                { 'fieldName': 'mobility', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'eingeschränkter Zugang zu geeigneten Lebensmitteln',
              'conditions':
              [
                { 'fieldName': 'accessToHealthPromotingFood', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'finanzielle Einschränkungen',
              'conditions':
              [
                { 'fieldName': 'financialResources', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'geringe Unterstützung im Alltag',
              'conditions':
              [
                { 'fieldName': 'supportByFamilyAndSocialNetwork', 'operator': '=', 'compareValue': '' }
              ]
            },
          ],
        },
      }
    );

    Goals defaultGoals = Goals.fromJson(
       {
        'elements': [],

        'suggestions':
        {
          'interventionsziele':
          [
            {
              'suggestedValue': 'Gewichtsreduktion unterstützen',
              'conditions':
              [
                { 'fieldName': 'bmi', 'operator': '>=', 'compareValue': 30 }
              ]
            },
            {
              'suggestedValue': 'Gewicht stabilisieren',
              'conditions':
              [
                { 'fieldName': 'bmi', 'operator': '>=', 'compareValue': 25 }
              ]
            },
            {
              'suggestedValue': 'Mahlzeitenstruktur verbessern',
              'conditions':
              [
                { 'fieldName': 'mealFrequency', 'operator': '<', 'compareValue': 3 }
              ]
            },
            {
              'suggestedValue': 'Nahrungs- und Flüssigkeitsaufnahme sichern',
              'conditions':
              [
                { 'fieldName': 'nutritionAndFluidIntake', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Mahlzeitenvorbereitung im Alltag erleichtern',
              'conditions':
              [
                { 'fieldName': 'mealPreparation', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Alltagsbewegung steigern',
              'conditions':
              [
                { 'fieldName': 'movementBehaviorAtWorkAndLeisure', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Stressbezogenes Essverhalten verbessern',
              'conditions':
              [
                { 'fieldName': 'stressManagement', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Ernährungsbezogenes Wissen stärken',
              'conditions':
              [
                { 'fieldName': 'knowledge', 'operator': '!=', 'compareValue': '' }
              ]
            },
          ],

          'handlungsziele':
          [
            {
              'suggestedValue': 'An mindestens 5 Tagen pro Woche eine Hauptmahlzeit planen',
              'conditions':
              [
                { 'fieldName': 'mealPreparation', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Täglich mindestens 3 Mahlzeiten einnehmen',
              'conditions':
              [
                { 'fieldName': 'mealFrequency', 'operator': '<', 'compareValue': 3 }
              ]
            },
            {
              'suggestedValue': 'Täglich ausreichend trinken',
              'conditions':
              [
                { 'fieldName': 'waterNeeds', 'operator': '!=', 'compareValue': 0 }
              ]
            },
            {
              'suggestedValue': '3 x pro Woche Bewegung im Alltag einplanen',
              'conditions':
              [
                { 'fieldName': 'movementBehaviorAtWorkAndLeisure', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Stresssituationen mit Essverhalten dokumentieren',
              'conditions':
              [
                { 'fieldName': 'stressManagement', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Bei Kau- oder Schluckproblemen geeignete Konsistenzen auswählen',
              'conditions':
              [
                { 'fieldName': 'chewing', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Einkauf von geeigneten Lebensmitteln vorbereiten',
              'conditions':
              [
                { 'fieldName': 'accessToHealthPromotingFood', 'operator': '!=', 'compareValue': '' }
              ]
            },
          ],

          'massnahmenziele':
          [
            {
              'suggestedValue': 'Gemeinsam einen Wochenplan erstellen',
              'conditions':
              [
                { 'fieldName': 'mealPreparation', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Mahlzeitenfrequenz und Tagesstruktur besprechen',
              'conditions':
              [
                { 'fieldName': 'mealFrequency', 'operator': '<', 'compareValue': 3 }
              ]
            },
            {
              'suggestedValue': 'Trinkprotokoll anlegen',
              'conditions':
              [
                { 'fieldName': 'waterNeeds', 'operator': '!=', 'compareValue': 0 }
              ]
            },
            {
              'suggestedValue': 'Bewegungsplan für Beruf und Freizeit erstellen', 
              'conditions':
              [
                { 'fieldName': 'movementBehaviorAtWorkAndLeisure', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Strategien für stressbedingtes Essen erarbeiten',
              'conditions':
              [
                { 'fieldName': 'stressManagement', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Geeignete Lebensmittel- und Konsistenzanpassungen besprechen',
              'conditions':
              [
                { 'fieldName': 'chewing', 'operator': '!=', 'compareValue': '' }
              ]
            },
            {
              'suggestedValue': 'Einkaufsliste mit geeigneten Lebensmitteln erstellen',
              'conditions':
              [
                { 'fieldName': 'accessToHealthPromotingFood', 'operator': '!=', 'compareValue': '' }
              ]
            },
          ],
        },
      }
    );

    Conversation conversation = Conversation(-1, DateUtil.getCurrentDate(), formMetaData ?? defaultFormMetaData, assessment ?? Assessment.fromJson({}), diagnosis ?? defaultDiagnosis, goals ?? defaultGoals, outcome ?? Outcome.fromJson({}), notes ?? "", selectedFilters ?? []);

    return conversation;
  }
}
