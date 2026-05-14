import 'package:app/config/layout/app_spacing.dart';
import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/form/form_base_element.dart';
import 'package:app/vo/form/form_date_element.dart';
import 'package:app/vo/form/form_element_category.dart';
import 'package:app/vo/form/form_number_element.dart';
import 'package:app/vo/form/form_selection_element.dart';
import 'package:app/vo/form/form_text_element.dart';
import 'package:app/vo/form/form_true_false_element.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/app_multiple_selection.dart';
import 'package:app/widgets/forms/app_radio_group.dart';
import 'package:app/widgets/sections/app_expandable_section.dart';
import 'package:flutter/material.dart';

class AppAssessmentFormWidget extends StatefulWidget
{
  final List<FormBaseElement> elements;
  final Assessment assessment;
  final ValueChanged<Assessment>? onChanged;

  const AppAssessmentFormWidget({ super.key, required this.elements, required this.assessment,
                                  this.onChanged });

  @override
  State<AppAssessmentFormWidget> createState() => _AppAssessmentFormWidgetState();
}

class _AppAssessmentFormWidgetState extends State<AppAssessmentFormWidget>
{
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState()
  {
    super.initState();
    _initializeFields();
  }

  void _initializeFields()
  {
    for(final element in widget.elements)
    {
      final existingValue = widget.assessment.getValue(element.name);

      if(element is FormTextElement)
      {
        final value = existingValue ?? element.defaultValue ?? '';
        _controllers[element.name] = TextEditingController(text: value.toString());

        widget.assessment.setValue(element.name, value);
      }

      if(element is FormNumberElement)
      {
        final value = existingValue ?? element.defaultValue ?? '';
        _controllers[element.name] = TextEditingController(text: value.toString());

        widget.assessment.setValue(element.name, value);
      }

      if(element is FormDateElement)
      {
        final value = existingValue ?? element.defaultValue;
        _controllers[element.name] = TextEditingController(text: value == null ? '' : value.toIso8601String().split('T').first);

        widget.assessment.setValue(element.name, value?.toIso8601String());
      }

      if(element is FormTrueFalseElement)
      {
        final value = existingValue ?? element.defaultValue ?? false;
        widget.assessment.setValue(element.name, value);
      }

      if(element is FormSelectionElement)
      {
        final selectedOptions = element.options.values.where((option) => option.selected).map((option) => option.name).toList();

        if(element.multipleSelection)
        {
          final value = existingValue ?? selectedOptions;
          widget.assessment.setValue(element.name, value);
        }
        
        else
        {
          final value = existingValue ?? (selectedOptions.isNotEmpty ? selectedOptions.first : null);
          widget.assessment.setValue(element.name, value);
        }
      }
    }
  }

  @override
  void dispose()
  {
    for(final controller in _controllers.values)
    {
      controller.dispose();
    }

    super.dispose();
  }

  void _setValue(String fieldName, dynamic value)
  {
    setState(() { widget.assessment.setValue(fieldName, value); });
    widget.onChanged?.call(widget.assessment);
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategorySection(
          title: 'Körperfunktion und -struktur',
          category: FormElementCategory.body,
          initiallyExpanded: true,
        ),

        AppSpacing.SPACED_BOX_H_SMALL,

        _buildCategorySection(
          title: 'Aktivitäten',
          category: FormElementCategory.activity,
        ),

        AppSpacing.SPACED_BOX_H_SMALL,

        _buildCategorySection(
          title: 'Partizipation',
          category: FormElementCategory.participation,
        ),

        AppSpacing.SPACED_BOX_H_SMALL,

        _buildCategorySection(
          title: 'Umweltfaktoren',
          category: FormElementCategory.environment,
        ),

        AppSpacing.SPACED_BOX_H_SMALL,

        _buildCategorySection(
          title: 'personenbez. Faktoren',
          category: FormElementCategory.personal,
        ),
      ],
    );
  }

  Widget _buildCategorySection({ required String title, required FormElementCategory category, bool initiallyExpanded = false })
  {
    final elements = widget.elements.where((element) => element.category == category).toList();

    return AppExpandableSection(
      title: title,
      initiallyExpanded: initiallyExpanded,
      child: elements.isEmpty
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final element in elements) ...[
                  _buildField(element),
                  AppSpacing.SPACED_BOX_H_MEDIUM,
                ],
              ],
            ),
    );
  }

  Widget _buildField(FormBaseElement element)
  {
    if(element is FormTextElement)
    {
      return AppLabeledField(
        label: element.displayName ?? element.name,
        controller: _controllers[element.name],
        onChanged: (value) {
          _setValue(element.name, value);
        },
      );
    }

    if(element is FormNumberElement)
    {
      return AppLabeledField(
        label: element.displayName ?? element.name,
        controller: _controllers[element.name],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final parsedValue = element.isInteger
              ? int.tryParse(value)
              : double.tryParse(value);

          _setValue(element.name, parsedValue);
        }
      );
    }

    if(element is FormDateElement)
    {
      return AppLabeledField(
        label: element.displayName ?? element.name,
        controller: _controllers[element.name],
        keyboardType: TextInputType.datetime,
        onChanged: (value) {
          _setValue(element.name, value);
        },
      );
    }

    if(element is FormTrueFalseElement)
    {
      return SwitchListTile(
        title: Text(
          element.displayName ?? element.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        value: widget.assessment.getValue(element.name) ?? false,
        onChanged: (value) {
          _setValue(element.name, value);
        },
      );
    }

    if(element is FormSelectionElement)
    {
      if(element.multipleSelection)
      {
        return _buildMultipleSelection(element);
      }

      return _buildSingleSelection(element);
    }

    return Text('Unbekannter Feldtyp: ${element.type.name}');
  }

  Widget _buildSingleSelection(FormSelectionElement element)
  {
    return AppRadioGroup<String>(
      title: element.displayName ?? element.name,
      options: element.options.keys.toList(),
      groupValue: widget.assessment.getValue(element.name),
      labelBuilder: (optionName) { return element.options[optionName]?.text ?? optionName; },
      onChanged: (value) { _setValue(element.name, value); }
    );
  }

  Widget _buildMultipleSelection(FormSelectionElement element)
  {
    final selectedValues = (widget.assessment.getValue(element.name) as List<dynamic>?) ?.cast<String>() ?? [];

    return AppMultipleSelection<String>(
      title: element.displayName ?? element.name,
      options: element.options.keys.toList(),
      selectedValues: selectedValues,
      labelBuilder: (optionName) { return element.options[optionName]?.text ?? optionName; },
      onChanged: (values) { _setValue(element.name, values); }
    );
  }
}

/*class AssessmentWidget extends StatefulWidget
{
  const AssessmentWidget({ super.key });

  @override
  State<AssessmentWidget> createState() => _AssessmentWidgetState();
}

class _AssessmentWidgetState extends State<AssessmentWidget>
{
  final TextEditingController _heightController = TextEditingController(text: '185');
  final TextEditingController _weightController = TextEditingController(text: '92');
  final TextEditingController _waistController = TextEditingController(text: '98');

  @override
  void dispose()
  {
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '14.01.2026';

    return AppPageScaffold(
      title: 'Assessment ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppNavigationTile(
            title: 'Filter',
            trailingIcon: Icons.filter_alt_outlined,
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_FILTER,
                arguments:
                {
                  'clientId': clientId,
                  'date': date,
                }
              );
            }
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppExpandableSection(
            title: 'Körperfunktion und -struktur',
            initiallyExpanded: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                AppLabeledSideTextField(
                  label: 'Größe (cm)',
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  sideIcon: Icons.delete_outline,
                  onSidePressed: ()
                  {
                    setState(()
                    {
                      _heightController.clear();
                    });
                  }
                ),

                AppSpacing.SPACED_BOX_H_MEDIUM,

                AppLabeledSideTextField(
                  label: 'Gewicht (kg)',
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  sideIcon: Icons.delete_outline,
                  onSidePressed: ()
                  {
                    setState(()
                    {
                      _weightController.clear();
                    });
                  }
                ),

                AppSpacing.SPACED_BOX_H_MEDIUM,

                AppLabeledSideTextField(
                  label: 'Taillenumfang (cm)',
                  controller: _waistController,
                  keyboardType: TextInputType.number,
                  sideIcon: Icons.delete_outline,
                  onSidePressed: ()
                  {
                    setState(()
                    {
                      _waistController.clear();
                    });
                  }
                )
              ]
            )
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppExpandableSection(
            title: 'Aktivitäten',
            initiallyExpanded: false,
            child: const SizedBox.shrink(),
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppExpandableSection(
            title: 'Partizipation',
            initiallyExpanded: false,
            child: const SizedBox.shrink(),
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppExpandableSection(
            title: 'Umweltfaktoren',
            initiallyExpanded: false,
            child: const SizedBox.shrink(),
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppExpandableSection(
            title: 'personenbez. Faktoren',
            initiallyExpanded: false,
            child: const SizedBox.shrink(),
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
                buttonText: 'Diagnose →',
                onPressed: ()
                {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_DIAGNOSIS,
                    arguments:
                    {
                      'clientId': clientId,
                      'date': date,
                    }
                  );
                }
              )
            ]
          )
        ]
      )
    );
  }
}
*/