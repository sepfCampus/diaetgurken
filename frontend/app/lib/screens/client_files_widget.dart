import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/app_search_field.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class ClientFilesWidget extends StatefulWidget
{
  const ClientFilesWidget({ super.key });

  @override
  State<ClientFilesWidget> createState() => _ClientFilesWidgetState();
}

class _ClientFilesWidgetState extends State<ClientFilesWidget>
{
  final TextEditingController _searchController = TextEditingController();

  String _searchText = '';

  final List<String> _clientFiles =
  [
    '000001',
    '000002',
    '000003',
    '000004',
    '000005',
    '000006',
    '000007',
    '000008',
  ];

  @override
  void dispose()
  {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final List<String> filteredClientFiles = _clientFiles.where((clientFile)
    {
      return clientFile.contains(_searchText);
    }).toList();

    return AppPageScaffold(
      title: 'Klientenakten',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppSearchField(
            controller: _searchController,
            hintText: 'Suchen ...',
            onChanged: (value)
            {
              setState(()
              {
                _searchText = value;
              });
            },

            onSearchPressed: ()
            {
              setState(()
              {
                _searchText = _searchController.text;
              });
            },
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppNavigationTile(
            title: 'Neu',
            trailingIcon: Icons.add,
            onTap: ()
            {
              Navigator.pushNamed(context, Routes.PAGE_CREATE_CLIENT_FILE);
            }
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          ...filteredClientFiles.map((clientFile)
          {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppStandardTileCard(
                title: clientFile,
                onTap: ()
                {
                  Navigator.pushNamed(context, Routes.PAGE_CLIENT_FILE, arguments: clientFile);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
