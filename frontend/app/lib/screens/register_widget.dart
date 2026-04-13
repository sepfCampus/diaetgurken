import 'package:app/screens/home_page_widget.dart';
import 'package:app/widgets/DTextField.dart';
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
                      DTextField(labelText: 'E-Mail'),

                      const SizedBox(height: 20),
                      DTextField(labelText: 'Registernr.'),

                      const SizedBox(height: 20),
                      DTextField(labelText: 'Passwort', hideInput: true),

                      const SizedBox(height: 20),
                      DTextField(labelText: 'Passwort bestätigen', hideInput: true),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          OutlinedButton(
                            onPressed: ()
                            {
                              Navigator.pop(context);
                            },
                            child: const Text('Login')
                          ),

                          const SizedBox(width: 12),

                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Registrieren')
                          )
                        ]
                      ),
//Ab hier später löschen: 
                      const SizedBox(height: 16),

                      Center(
                        child: IconButton(
                          onPressed: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePageWidget()
                              )
                            );
                          },
                          icon: const Icon(Icons.arrow_downward),
                        ),
                      ), //Bis hier SPÄTER LÖSCHEN - homepage
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