import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/user_service.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registerNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _registerNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showPasswordForgotten() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Passwort vergessen?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bitte wenden Sie sich per E-Mail an die Administratoren:'),
          const SizedBox(height: 12),
          const SelectableText('loretta.malinovic@stud.hcw.ac.at'),
          const SelectableText('alexandra.monte@stud.hcw.ac.at'),
          const SelectableText('florian.gebauer@stud.hcw.ac.at'),
          const SelectableText('sebastian.pfeiffer@stud.hcw.ac.at'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Schließen'),
        ),
      ],
    ),
  );
}

  String? _validate() {
    final email = _emailController.text.trim();
    final registerNr = _registerNumberController.text.trim();
    final passwort = _passwordController.text;

    if (email.isEmpty || registerNr.isEmpty || passwort.isEmpty) {
      return 'Bitte alle Felder ausfüllen.';
    }

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Ungültige E-Mail-Adresse.';
    }

    if (passwort.length < 6) {
      return 'Passwort muss mindestens 6 Zeichen lang sein.';
    }

    return null;
  }

  Future<void> _login() async {
    final error = _validate();
    if (error != null) {
      setState(() => _errorMessage = error);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userService = context.read<UserService>();
      await userService.login(
        _emailController.text.trim(),
        _registerNumberController.text.trim(),
        _passwordController.text
      );

      if (mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.PAGE_HOME, (route) => false);
      }
    } catch (e) {
      setState(
        () => _errorMessage = 'Login fehlgeschlagen. Bitte Daten überprüfen.',
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.PAGE_PADDING,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.MAX_CONTENT_WIDTH,
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      hintText: 'E-Mail',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    AppTextField(
                      hintText: 'Registernr.',
                      controller: _registerNumberController,
                    ),

                    AppSpacing.SPACED_BOX_H_LARGE,

                    AppTextField(
                      hintText: 'Passwort',
                      controller: _passwordController,
                      obscureText: true,
                    ),

                    AppSpacing.SPACED_BOX_H_SMALL,

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showPasswordForgotten,
                        child: Text(
                          'Passwort vergessen?',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    if (_errorMessage != null) ...[
                      AppSpacing.SPACED_BOX_H_SMALL,
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ],

                    AppSpacing.SPACED_BOX_H_LARGE,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppSecondaryButton(
                          buttonText: 'Registrieren',
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.PAGE_REGISTER);
                          },
                        ),

                        AppSpacing.SPACED_BOX_W_SMALL,

                        _isLoading
                            ? const CircularProgressIndicator()
                            : AppPrimaryButton(
                                buttonText: 'Login',
                                onPressed: _login,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
