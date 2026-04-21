import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/sections/app_expandable_section.dart';
import 'package:app/widgets/tiles/app_labeled_side_text_field.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';

class AssessmentWidget extends StatefulWidget
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
