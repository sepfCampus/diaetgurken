import 'package:flutter/material.dart';

//A reusable container for sections
class AppSectionCard extends StatelessWidget
{
  final Widget child; //content of the card
  final EdgeInsetsGeometry? padding; //inner padding
  final VoidCallback? onTap;

  const AppSectionCard({ super.key, required this.child, this.padding, this.onTap });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    final Widget content = Container(
      width: double.infinity, //card is as wide as the possible
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child
    );

    if(onTap != null)
    {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: content,
      );
    }

    return content;
  }
}
