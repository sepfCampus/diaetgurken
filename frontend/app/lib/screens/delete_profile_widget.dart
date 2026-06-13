import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/user_service.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteProfileWidget extends StatelessWidget
{
  const DeleteProfileWidget({ super.key });

  @override
  Widget build(BuildContext context)
  {
    return AppPageScaffold(
      title: 'Profil löschen',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text(
            'Profil wirklich löschen?',
            style: Theme.of(context).textTheme.bodyMedium
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          SizedBox(
            width: double.infinity,
            child: AppSecondaryButton(
              buttonText: 'Profil löschen',
              onPressed: () async
              {
                final service = context.read<UserService>();
                
                final user = await service.getCurrentUser();
                await service.deleteUser(user);

                Navigator.pushNamedAndRemoveUntil(context, Routes.PAGE_LOGIN, (route) => false);
              }
            )
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          SizedBox(
            width: double.infinity,
            child: AppPrimaryButton(
              buttonText: 'Abbrechen',
              onPressed: ()
              {
                Navigator.pop(context);
              }
            )
          )
        ],
      )
    );
  }
}
