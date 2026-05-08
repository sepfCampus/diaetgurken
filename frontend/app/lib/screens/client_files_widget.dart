import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/klienten_akte_http_service.dart';
import 'package:app/widgets/forms/app_search_field.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<Map<String, dynamic>> _clientFiles = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState()
  {
    super.initState();
    _loadClientFiles();
  }

  Future<void> _loadClientFiles() async
  {
    setState(() { _isLoading = true; _errorMessage = null; });

    try
    {
      final service = context.read<KlientenAkteHttpService>();
      final files = await service.getAll();
      setState(() => _clientFiles = files);
    }
    catch (e)
    {
      setState(() => _errorMessage = 'Fehler beim Laden der Klientenakten.');
    }
    finally
    {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _formatId(Map<String, dynamic> file)
  {
    final id = file['id'] as int? ?? 0;
    return id.toString().padLeft(4, '0');
  }

  @override
  void dispose()
  {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final filtered = _clientFiles.where((file)
    {
      return _formatId(file).contains(_searchText);
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
              setState(() => _searchText = value);
            },
            onSearchPressed: ()
            {
              setState(() => _searchText = _searchController.text);
            },
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppNavigationTile(
            title: 'Neu',
            trailingIcon: Icons.add,
            onTap: () async
            {
              await Navigator.pushNamed(context, Routes.PAGE_CREATE_CLIENT_FILE);
              _loadClientFiles();
            },
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )
          else
            ...filtered.map((file)
            {
              final displayId = _formatId(file);
              final id = file['id']?.toString() ?? '';
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppStandardTileCard(
                  title: displayId,
                  onTap: ()
                  {
                    Navigator.pushNamed(context, Routes.PAGE_CLIENT_FILE, arguments: id);
                  },
                ),
              );
            }),
        ],
      ),
    );
  }
}