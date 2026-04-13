import 'package:app/widgets/DTextField.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget
{
  const LoginWidget({ super.key });

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children:
            [
              const SizedBox(height: 80),
              DTextField(labelText: 'E-Mail'),

              const SizedBox(height: 20),
              DTextField(labelText: 'Registernr.'),

              const SizedBox(height: 20),
              DTextField(labelText: 'Passwort', hideInput: true),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:
                [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Registrieren')
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Login'))
                ])
            ],)
        ))
    );
  }
}
