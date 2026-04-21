import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/layout/app_drawer.dart';
import 'package:app/widgets/layout/app_header.dart';
import 'package:flutter/material.dart';

class AppPageScaffold extends StatelessWidget
{
  final String title; //page title shown in the header
  final Widget child; //page content
  final AppDrawer? drawer; //optional side drawer
  final Widget? leading; //optional left widget in the header
  final Widget? trailing; //optional right widget in the header
  final EdgeInsets padding; //page content padding
  final bool scrollable; //decides if body should scroll
  final double? maxContentWidth;

  const AppPageScaffold({ super.key, required this.title, required this.child, this.drawer,
                          this.leading, this.trailing, this.padding = AppSpacing.PAGE_PADDING,
                          this.scrollable = true, this.maxContentWidth = AppSizes.MAX_CONTENT_WIDTH });

  @override
  Widget build(BuildContext context)
  {
    Widget content = Padding(
      padding: padding,
      child: maxContentWidth != null
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth!), //prevents content from becoming too wide on large screens
                child: child,
              ),
            )
          : child,
    );

    if(scrollable)
    {
      content = SingleChildScrollView(child: content);
    }

    return Scaffold(
      appBar: AppHeader(title: title, leading: leading, trailing: trailing),
      drawer: drawer,
      body: SafeArea(
        top: false,
        child: content
      )
    );
  }
}
