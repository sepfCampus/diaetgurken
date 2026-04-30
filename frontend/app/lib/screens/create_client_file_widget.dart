import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';

class CreateClientFileWidget extends StatefulWidget
{
  const CreateClientFileWidget({ super.key });

  @override
  State<CreateClientFileWidget> createState() => _CreateClientFileWidgetState();
}

class _CreateClientFileWidgetState extends State<CreateClientFileWidget>
{
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose()
  {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return AppPageScaffold(
      title: 'Neue Klientenakte',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppTextField(
            controller: _nameController,
            hintText: 'Name',
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
                buttonText: 'Speichern',
                onPressed: ()
                {
                  Navigator.pushNamed(context, Routes.PAGE_CLIENT_FILES);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
