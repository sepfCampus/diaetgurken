import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget
{
  const LoginWidget({ super.key });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registerNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose()
  {
    _emailController.dispose();
    _registerNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.PAGE_PADDING,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.MAX_CONTENT_WIDTH),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
            
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    AppTextField(
                      hintText: 'E-Mail',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    AppTextField(
                      hintText: 'Registernr.',
                      controller: _registerNumberController
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    AppTextField(
                      hintText: 'Passwort',
                      controller: _passwordController,
                      obscureText: true
                    ),

                    AppSpacing.SPACED_BOX_H_EXTRA_EXTRA_LARGE,

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

                        AppSpacing.SPACED_BOX_W_SMALL,

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
    );
  }
}
