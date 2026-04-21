import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget
{
  const RegisterWidget({ super.key });

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget>
{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registerNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose()
  {
    _emailController.dispose();
    _registerNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
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
                  children:
                  [
                    AppTextField(
                      controller: _emailController,
                      hintText: 'E-Mail',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    AppTextField(
                      controller: _registerNumberController,
                      hintText: 'Registernr.',
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    AppTextField(
                      controller: _passwordController,
                      hintText: 'Passwort',
                      obscureText: true,
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    AppTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Passwort bestätigen',
                      obscureText: true
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                      [
                        AppSecondaryButton(
                          buttonText: 'Login',
                          width: AppSizes.BUTTON_WIDTH_SMALL,
                          onPressed: ()
                          {
                            Navigator.of(context).pushNamedAndRemoveUntil(Routes.PAGE_LOGIN, (route) => false);
                          }
                        ),

                        AppSpacing.SPACED_BOX_W_SMALL,

                        AppPrimaryButton(
                          buttonText: 'Registrieren',
                          width: AppSizes.BUTTON_WIDTH_MEDIUM,
                          onPressed: ()
                          {
                            Navigator.of(context).pushNamedAndRemoveUntil(Routes.PAGE_HOME, (route) => false);
                          })
                      ],
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
