import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_filter_chip_tile.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget
{
  const FilterWidget({ super.key });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget>
{
  final Set<String> _selectedFilters = { 'Übergewicht' };

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '14.01.2026';

    return AppPageScaffold(
      title: 'Filter ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      trailing: AppNotesButton(clientId: clientId, date: date),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          // FILTER CHIPS
          Wrap(
            spacing: AppSpacing.SM,
            runSpacing: AppSpacing.SM,
            children:
            [
              AppFilterChipTile(
                label: 'Übergewicht',
                selected: _selectedFilters.contains('Übergewicht'),
                onPressed: ()
                {
                  setState(()
                  {
                    if(_selectedFilters.contains('Übergewicht'))
                    {
                      _selectedFilters.remove('Übergewicht');
                    }
                    else
                    {
                      _selectedFilters.add('Übergewicht');
                    }
                  });
                }
              )
            ]
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          // BUTTONS
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
                buttonText: 'Speichern',
                onPressed: ()
                {

                }
              )
            ]
          )
        ]
      )
    );
  }
}
