import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/sections/app_expandable_section.dart';
import 'package:app/widgets/tiles/app_labeled_combo_field.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';

class DiagnosisWidget extends StatefulWidget
{
  const DiagnosisWidget({ super.key });

  @override
  State<DiagnosisWidget> createState() => _DiagnosisWidgetState();
}

class _DiagnosisWidgetState extends State<DiagnosisWidget>
{
  final List<_DiagnosisEntry> _diagnoses =
  [
    _DiagnosisEntry.empty(),
  ];

  final List<String> _problemOptions =
  [
    'Unzureichende Energieaufnahme',
    'Unbeabsichtigter Gewichtsverlust',
    'Erhöhter Energiebedarf',
    'Mangelernährung',
    'Schluckstörung',
  ];

  final List<String> _etiologyOptions =
  [
    'verminderter Appetit',
    'erhöhter Bedarf durch Erkrankung',
    'Schluckbeschwerden',
    'unzureichende Nahrungszufuhr',
    'gastrointestinale Beschwerden',
  ];

  final List<String> _signsAndSymptomsOptions =
  [
    'Gewichtsverlust',
    'niedrige Energieaufnahme',
    'Müdigkeit',
    'reduzierter Ernährungszustand',
    'verminderte Muskelmasse',
  ];

  final List<String> _supportingFactorsOptions =
  [
    'hohe Motivation',
    'familiäre Unterstützung',
    'gute Compliance',
    'regelmäßige Verlaufskontrollen',
    'Hilfsmittel vorhanden',
  ];

  final List<String> _barrierOptions =
  [
    'geringe Motivation',
    'soziale Isolation',
    'finanzielle Einschränkungen',
    'kognitive Einschränkungen',
    'fehlende Unterstützung',
  ];

  @override
  void dispose()
  {
    for(final diagnosis in _diagnoses)
    {
      diagnosis.dispose();
    }

    super.dispose();
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

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '14.01.2026';

    return AppPageScaffold(
      title: 'Diagnose ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          ...List.generate(_diagnoses.length, (index)
          {
            final _DiagnosisEntry diagnosis = _diagnoses[index];

            final List<_DiagnosisFieldConfig> fields =
            [
              _DiagnosisFieldConfig(
                label: 'Problem',
                hintText: 'Beschreibung des Problems ...',
                controller: diagnosis.problemController,
                options: _problemOptions,
              ),
              _DiagnosisFieldConfig(
                label: 'Etiology',
                hintText: 'Beschreibung der Etiology ...',
                controller: diagnosis.etiologyController,
                options: _etiologyOptions,
              ),
              _DiagnosisFieldConfig(
                label: 'Signs & Symptoms',
                hintText: 'Beschreibung der Signs & Symptoms ...',
                controller: diagnosis.signsAndSymptomsController,
                options: _signsAndSymptomsOptions,
              ),
              _DiagnosisFieldConfig(
                label: 'Förderfaktoren',
                hintText: 'Beschreibung der Förderfaktoren ...',
                controller: diagnosis.supportingFactorsController,
                options: _supportingFactorsOptions,
              ),
              _DiagnosisFieldConfig(
                label: 'Barrieren',
                hintText: 'Beschreibung der Barrieren ...',
                controller: diagnosis.barriersController,
                options: _barrierOptions,
              ),
            ];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _diagnoses.length - 1 ? AppSpacing.MD : AppSpacing.SM,
              ),
              child: AppExpandableSection(
                title: 'Diagnose',
                initiallyExpanded: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    ...List.generate(fields.length, (fieldIndex)
                    {
                      final _DiagnosisFieldConfig field = fields[fieldIndex];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: fieldIndex == fields.length - 1 ? 0 : AppSpacing.SM,
                        ),
                        child: AppLabeledComboField(
                          label: field.label,
                          controller: field.controller,
                          hintText: field.hintText,
                          options: field.options,
                        )
                      );
                    }),

                    AppSpacing.SPACED_BOX_H_MEDIUM,

                    Align(
                      alignment: Alignment.centerRight,
                      child: AppSecondaryButton(
                        buttonText: 'Löschen',
                        width: AppSizes.BUTTON_WIDTH_SMALL,
                        onPressed: _diagnoses.length > 1
                            ? ()
                              {
                                _removeDiagnosis(index);
                              }
                            : null,
                      ),
                    )
                  ]
                )
              )
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
            children:
            [
              AppSecondaryButton(
                buttonText: 'Abbrechen',
                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Outcome-Evaluation →',
                onPressed: ()
                {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_OUTCOME_EVALUATION,
                    arguments:
                    {
                      'clientId': clientId,
                      'date': date,
                    }
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class _DiagnosisFieldConfig
{
  final String label;
  final String hintText;
  final TextEditingController controller;
  final List<String> options;

  _DiagnosisFieldConfig({ required this.label, required this.hintText, required this.controller,
                          required this.options });
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
      barriersController: TextEditingController(),
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
