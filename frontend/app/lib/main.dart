import 'package:app/screens/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/config/theme/AppTheme.dart';

void main()
{
  runApp(const MainApp());
}

class MainApp extends StatelessWidget
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.LIGHT,  // LIGHT oder HIGH_CONTRAST
      home: const LoginWidget()
    );
  }
}
