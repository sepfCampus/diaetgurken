import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/app_assessment_form_widget.dart';
import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/form/form_meta_data.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';

class AssessmentWidget extends StatefulWidget
{
  const AssessmentWidget({super.key});

  @override
  State<AssessmentWidget> createState() => _AssessmentWidgetState();
}

class _AssessmentWidgetState extends State<AssessmentWidget>
{
  late Map<String, dynamic> _conversation;
  late FormMetaData _formMetaData;
  late Assessment _assessment;

  bool _initialized = false;

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    if(_initialized)
    {
      return;
    }

    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    _conversation = args?['conversation'] as Map<String, dynamic>;

    _formMetaData = FormMetaData.fromJson(_conversation['formMetaData']);
    _assessment = Assessment.fromJson(_conversation['assessment']);

    _initialized = true;
  }

@override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '?';
    final String date = args?['date'] ?? '?';

    return AppPageScaffold(
      title: 'Assessment ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(conversation: _conversation, clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppNavigationTile(
            title: 'Filter',
            trailingIcon: Icons.filter_alt_outlined,
            onTap: ()
            {
              Navigator.pushNamed(context, Routes.PAGE_FILTER,
                                  arguments: { 'clientId': clientId, 'date': date, 'conversation': _conversation });
            }
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppAssessmentFormWidget(
            elements: _formMetaData.elements,
            assessment: _assessment,
            onChanged: (assessment)
            {
              _conversation['assessment'] = assessment.toJson();
            },
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
              AppSecondaryButton(
                buttonText: 'Zurück',
                onPressed: ()
                {
                  _conversation['assessment'] = _assessment.toJson();

                  Navigator.pop(context, _conversation);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Diagnose →',
                onPressed: ()
                {
                  _conversation['assessment'] = _assessment.toJson();

                  Navigator.pushReplacementNamed(context, Routes.PAGE_DIAGNOSIS,
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
