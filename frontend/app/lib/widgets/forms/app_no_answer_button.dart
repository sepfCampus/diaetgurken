import 'package:flutter/material.dart';

class AppNoAnswerButton extends StatelessWidget
{
  final bool selected;
  final VoidCallback? onPressed;

  const AppNoAnswerButton({ super.key, required this.selected, this.onPressed });

  @override
  Widget build(BuildContext context)
  {
    return IconButton(
      tooltip: 'Keine Angabe',
      icon: Icon(
        Icons.block,
        color: selected
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
      ),
      style: IconButton.styleFrom(
        backgroundColor: selected
            ? Theme.of(context).colorScheme.error.withOpacity(0.18)
            : Colors.transparent,
        shape: const CircleBorder(),
      ),
      onPressed: onPressed,
    );
  }
}
