import 'package:app/config/navigation/routes.dart';
import 'package:app/service/user_http_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatefulWidget
{
  final Widget child;

  const AuthGuard({ super.key, required this.child });

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard>
{
  bool _checking = true;

  @override
  void initState()
  {
    super.initState();
    _check();
  }

  Future<void> _check() async
  {
    try
    {
      final userService = context.read<UserHttpService>();
      final isLoggedIn = await userService.isLoggedIn();

      if (mounted)
      {
        if (!isLoggedIn)
        {
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.PAGE_LOGIN, (route) => false);
        }
        else
        {
          setState(() => _checking = false);
        }
      }
    }
    catch (e)
    {
      if (mounted)
      {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.PAGE_LOGIN, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context)
  {
    if (_checking)
    {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return widget.child;
  }
}