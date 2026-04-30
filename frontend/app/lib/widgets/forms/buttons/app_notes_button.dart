import 'package:app/config/navigation/routes.dart';
import 'package:flutter/material.dart';

class AppNotesButton extends StatelessWidget
{
  final String clientId;
  final String date;

  const AppNotesButton({ super.key, required this.clientId, required this.date });

  @override
  Widget build(BuildContext context)
  {
    return IconButton(
      icon: const Icon(Icons.menu_book_outlined),
      onPressed: ()
      {
        Navigator.pushNamed(context, Routes.PAGE_CONVERSATION_NOTES, arguments:
                            { 'clientId': clientId, 'date': date });
      }
    );
  }
}
