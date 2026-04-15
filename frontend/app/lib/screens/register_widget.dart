import 'package:app/config/navigation/routes.dart';
import 'package:app/screens/home_page_widget.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget
{
  const RegisterWidget({ super.key });

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

                      const SizedBox(height: 20),
                      AppTextField(labelText: 'Passwort bestätigen', obscureText: true),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          OutlinedButton(
                            onPressed: ()
                            {
                              //remove all routes and replace them by the home screen
                              Navigator.of(context).pushNamedAndRemoveUntil(Routes.PAGE_LOGIN, (route) => false);
                            },
                            child: const Text('Login')
                          ),

                          const SizedBox(width: 12),

                          ElevatedButton(
                            onPressed: () { Navigator.pushNamed(context, Routes.PAGE_HOME); },
                            child: const Text('Registrieren')
                          )
                        ]
                      ),
//Ab hier später löschen: 
                      const SizedBox(height: 16), //Bis hier SPÄTER LÖSCHEN - homepage
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
