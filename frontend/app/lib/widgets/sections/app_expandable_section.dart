import 'package:app/widgets/sections/app_section_card.dart';
import 'package:flutter/material.dart';

class AppExpandableSection extends StatefulWidget
{
  final String title; //title shown in the section header
  final Widget child; //content shown when expanded
  final bool initiallyExpanded; //true => expanded by default
  final VoidCallback? onHeaderTap; //optional callback when header is tapped

  const AppExpandableSection({ super.key, required this.title, required this.child,
                               this.initiallyExpanded = false, this.onHeaderTap });

  @override
  State<AppExpandableSection> createState() => _AppExpandableSectionState();
}

class _AppExpandableSectionState extends State<AppExpandableSection>
{
  late bool _expanded; //stores whether the section is expanded or not

  @override
  void initState()
  {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    return AppSectionCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()
            {
              setState(()
              {
                _expanded = !_expanded; // toggles the section open/closed
              });

              if(widget.onHeaderTap != null)
              {
                widget.onHeaderTap!(); //runs optional external callback
              }
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // spacing inside the header area
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(6),
                  bottom: Radius.circular(_expanded ? 0 : 6), // rounds the bottom only when collapsed
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more, // changes the icon depending on state
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ),

          if(_expanded)
            Padding(
              padding: const EdgeInsets.all(12),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}
