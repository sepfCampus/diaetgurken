import 'package:app/config/layout/app_spacing.dart';
import 'package:app/vo/conversation.dart';
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
  late Conversation _conversation;

  final Set<String> _selectedFilters = {};

  bool _initialized = false;

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    if(_initialized)
    {
      return;
    }

    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    _conversation = args?['conversation'] as Conversation;

    final storedFilters = (_conversation.selectedFilters as List<dynamic>? ?? []).cast<String>();

    _selectedFilters.addAll(storedFilters);

    _initialized = true;
  }

  List<String> _getAvailableFilters()
  {
    final Set<String> filters = {};

    final formMetaData =
        _conversation.formMetaData as Map<String, dynamic>;

    final elements =
        formMetaData['elements'] as List<dynamic>? ?? [];

    for(final element in elements)
    {
      final filterOptions =
          element['filterOptions'] as List<dynamic>? ?? [];

      for(final filter in filterOptions)
      {
        filters.add(filter.toString());
      }
    }

    return filters.toList()..sort();
  }

  void _updateConversationFilters()
  {
    _conversation.selectedFilters = _selectedFilters.toList();
  }

  void _toggleFilter(String filter)
  {
    setState(()
    {
      if(_selectedFilters.contains(filter))
      {
        _selectedFilters.remove(filter);
      }

      else
      {
        _selectedFilters.add(filter);
      }

      _updateConversationFilters();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '?';
    final String date = args?['date'] ?? '?';

    final availableFilters = _getAvailableFilters();

    return AppPageScaffold(
      title: 'Filter ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      trailing: AppNotesButton(
        conversation: _conversation,
        clientId: clientId,
        date: date,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Wrap(
            spacing: AppSpacing.SM,
            runSpacing: AppSpacing.SM,
            children:
            [
              ...availableFilters.map((filter)
              {
                return AppFilterChipTile(
                  label: filter,
                  selected: _selectedFilters.contains(filter),
                  onPressed: ()
                  {
                    _toggleFilter(filter);
                  },
                );
              }),
            ],
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
                  Navigator.pop(context);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Speichern',
                onPressed: ()
                {
                  _updateConversationFilters();

                  Navigator.pop(context);
                },
              )
            ]
          )
        ]
      )
    );
  }
}
