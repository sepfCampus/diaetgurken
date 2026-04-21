import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';

class ClearNameWidget extends StatefulWidget
{
  const ClearNameWidget({ super.key });

  @override
  State<ClearNameWidget> createState() => _ClearNameWidgetState();
}

class _ClearNameWidgetState extends State<ClearNameWidget>
{
  final TextEditingController _passwordController = TextEditingController();

  String _selectedClient = '000009';

  @override
  void dispose()
  {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    return AppPageScaffold(
      title: 'Klarnamen',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text(
          'Klientenakte',
          style: theme.textTheme.bodyMedium
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppNavigationTile(
            title: _selectedClient,
            trailingIcon: Icons.keyboard_arrow_down,
            onTap: () {},
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppTextField(
            controller: _passwordController,
            hintText: 'Passwort',
            obscureText: true,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border.all(
                color: theme.colorScheme.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Max Mustermann',
              style: theme.textTheme.bodyMedium,
            ),
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSecondaryButton(
                buttonText: 'Abbrechen',
                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Anzeigen',
                onPressed: ()
                {

                },
              ),
            ],
          )
        ]
      )
    );
  }
}
