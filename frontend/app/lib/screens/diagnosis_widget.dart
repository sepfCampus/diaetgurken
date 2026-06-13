import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/diagnosis/diagnosis.dart';
import 'package:app/vo/diagnosis/diagnosis_element.dart';
import 'package:app/vo/util/diagnosis_suggestion_util.dart';
import 'package:app/vo/util/formatter.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/sections/app_expandable_section.dart';
import 'package:app/widgets/tiles/app_labeled_combo_field.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';

class _DiagnosisFieldConfig
{
  final String label;
  final String hintText;
  final TextEditingController controller;
  final List<String> options;

  _DiagnosisFieldConfig({ required this.label, required this.hintText,
                          required this.controller, required this.options });
}

class _DiagnosisEntry
{
  final TextEditingController problemController;
  final TextEditingController etiologyController;
  final TextEditingController signsAndSymptomsController;
  final TextEditingController supportingFactorsController;
  final TextEditingController barriersController;

  _DiagnosisEntry({ required this.problemController, required this.etiologyController,
                    required this.signsAndSymptomsController, required this.supportingFactorsController,
                    required this.barriersController });

  factory _DiagnosisEntry.empty()
  {
    return _DiagnosisEntry(
      problemController: TextEditingController(),
      etiologyController: TextEditingController(),
      signsAndSymptomsController: TextEditingController(),
      supportingFactorsController: TextEditingController(),
      barriersController: TextEditingController());
  }

  factory _DiagnosisEntry.fromDiagnosisElement(DiagnosisElement diagnosis)
  {
    return _DiagnosisEntry(
      problemController: TextEditingController(text: diagnosis.problem),
      etiologyController: TextEditingController(text: diagnosis.etiology),
      signsAndSymptomsController: TextEditingController(text: diagnosis.signsAndSymptoms),
      supportingFactorsController: TextEditingController(text: diagnosis.foerderfaktoren),
      barriersController: TextEditingController(text: diagnosis.barrieren),
    );
  }

  void dispose()
  {
    problemController.dispose();
    etiologyController.dispose();
    signsAndSymptomsController.dispose();
    supportingFactorsController.dispose();
    barriersController.dispose();
  }
}

class DiagnosisWidget extends StatefulWidget
{
  const DiagnosisWidget({ super.key });

  @override
  State<DiagnosisWidget> createState() => _DiagnosisWidgetState();
}

class _DiagnosisWidgetState extends State<DiagnosisWidget>
{
  late Conversation _conversation;
  late Diagnosis _diagnosis;
  late Assessment _assessment;

  final List<_DiagnosisEntry> _diagnoses = [ ];

  bool _initialized = false;

  @override
  void dispose()
  {
    for(final diagnosis in _diagnoses)
    {
      diagnosis.dispose();
    }

    super.dispose();
  }

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    if(_initialized)
    {
      return;
    }

    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    _conversation = args?['conversation'] as Conversation;

    _assessment = _conversation.assessment;
    _diagnosis = _conversation.diagnosen;

    _diagnoses.clear();

    if(_diagnosis.elements.isEmpty)
    {
      _diagnoses.add(_DiagnosisEntry.empty());
    }

    else
    {
      for(final diagnosis in _diagnosis.elements)
      {
        _diagnoses.add(_DiagnosisEntry.fromDiagnosisElement(diagnosis));
      }
    }

    _initialized = true;
  }

  List<String> _getVisibleSuggestions(String fieldName)
  {
    final suggestions = _diagnosis.suggestions[fieldName] ?? [];

    return DiagnosisSuggestionUtil.getSuggestionsToShow(suggestions, _assessment);
  }

  void _addDiagnosis()
  {
    setState(()
    {
      _diagnoses.add(_DiagnosisEntry.empty());
    });
  }

  void _removeDiagnosis(int index)
  {
    setState(()
    {
      _diagnoses[index].dispose();
      _diagnoses.removeAt(index);
    });
  }

  Diagnosis _buildDiagnosisFromUi()
  {
    return Diagnosis(
      elements: _diagnoses.map((entry)
      {
        return DiagnosisElement(
          problem: entry.problemController.text,
          etiology: entry.etiologyController.text,
          signsAndSymptoms: entry.signsAndSymptomsController.text,
          foerderfaktoren: entry.supportingFactorsController.text,
          barrieren: entry.barriersController.text,
        );
      }).toList(),
      suggestions: _diagnosis.suggestions,
    );
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final int clientId = args?['clientId'] ?? -1;
    final String date = args?['date'] ?? '?';

    return AppPageScaffold(
      title: 'Diagnose (${Formatter.formatClientId(clientId)}) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(conversation: _conversation, clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(_diagnoses.length, (index) {
            final _DiagnosisEntry diagnosis = _diagnoses[index];

            final List<_DiagnosisFieldConfig> fields = [
              _DiagnosisFieldConfig(
                label: 'Problem',
                hintText: "",
                //hintText: 'Beschreibung des Problems ...',
                controller: diagnosis.problemController,
                options: _getVisibleSuggestions('problem'),
              ),
              _DiagnosisFieldConfig(
                label: 'Etiology',
                hintText: "",
                //hintText: 'Beschreibung der Etiology ...',
                controller: diagnosis.etiologyController,
                options: _getVisibleSuggestions('etiology'),
              ),
              _DiagnosisFieldConfig(
                label: 'Signs & Symptoms',
                hintText: "",
                //hintText: 'Beschreibung der Signs & Symptoms ...',
                controller: diagnosis.signsAndSymptomsController,
                options: _getVisibleSuggestions('signsAndSymptoms'),
              ),
              _DiagnosisFieldConfig(
                label: 'Förderfaktoren',
                hintText: "",
                //hintText: 'Beschreibung der Förderfaktoren ...',
                controller: diagnosis.supportingFactorsController,
                options: _getVisibleSuggestions('foerderfaktoren'),
              ),
              _DiagnosisFieldConfig(
                label: 'Barrieren',
                hintText: "",
                //hintText: 'Beschreibung der Barrieren ...',
                controller: diagnosis.barriersController,
                options: _getVisibleSuggestions('barrieren'),
              ),
            ];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _diagnoses.length - 1
                    ? AppSpacing.MD
                    : AppSpacing.SM,
              ),
              child: AppExpandableSection(
                title: 'Diagnose ${index + 1}',
                initiallyExpanded: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(fields.length, (fieldIndex) {
                      final _DiagnosisFieldConfig field = fields[fieldIndex];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: fieldIndex == fields.length - 1
                              ? 0
                              : AppSpacing.SM,
                        ),
                        child: AppLabeledComboField(
                          label: field.label,
                          controller: field.controller,
                          hintText: field.hintText,
                          options: field.options,
                        ),
                      );
                    }),

                    AppSpacing.SPACED_BOX_H_MEDIUM,

                    Align(
                      alignment: Alignment.centerRight,
                      child: AppSecondaryButton(
                        buttonText: 'Löschen',
                        width: AppSizes.BUTTON_WIDTH_SMALL,
                        onPressed: _diagnoses.length > 1
                            ? () {
                                _removeDiagnosis(index);
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          AppNavigationTile(
            title: 'Neu',
            trailingIcon: Icons.add,
            onTap: _addDiagnosis,
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSecondaryButton(
                buttonText: 'Zurück',
                onPressed: () {
                  _conversation.diagnosen = _buildDiagnosisFromUi();
                  Navigator.pushReplacementNamed(context, Routes.PAGE_ASSESSMENT,
                                                 arguments: { 'clientId': clientId, 'date': date, 'conversation': _conversation });
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Outcome-Evaluation →',
                onPressed: () {
                  _conversation.diagnosen = _buildDiagnosisFromUi();
                  Navigator.pushReplacementNamed(context, Routes.PAGE_OUTCOME_EVALUATION,
                                                 arguments: { 'clientId': clientId, 'date': date, 'conversation': _conversation });
                }
              )
            ]
          )
        ]
      )
    );
  }
}
