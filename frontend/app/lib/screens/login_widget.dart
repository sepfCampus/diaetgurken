import 'package:app/config/navigation/routes.dart';
import 'package:app/screens/register_widget.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/app_radio_group.dart';
import 'package:app/widgets/forms/app_search_field.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget
{
  const LoginWidget({ super.key });

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                    [
                      AppTextField(labelText: 'E-Mail'),

                      const SizedBox(height: 20),
                      AppTextField(labelText: 'Registernr.'),

                      const SizedBox(height: 20),
                      AppTextField(labelText: 'Passwort', obscureText: true),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          AppSecondaryButton(
                            buttonText: 'Registrieren',
                            onPressed: ()
                            {
                              Navigator.pushNamed(context, Routes.PAGE_REGISTER);
                            }
                          ),

                          const SizedBox(width: 12),

                          AppPrimaryButton(
                            buttonText: 'Login',
                            onPressed: ()
                            {
                              Navigator.of(context).pushNamedAndRemoveUntil(Routes.PAGE_HOME, (route) => false);
                            }
                          )
                        ]
                      )
                    ],
                  )
                )
              )
            )
          )
        )
      )
    );
  }
}