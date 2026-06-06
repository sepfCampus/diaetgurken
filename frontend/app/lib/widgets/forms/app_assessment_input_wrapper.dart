import 'package:app/widgets/forms/app_no_answer_button.dart';
import 'package:flutter/material.dart';

class AppAssessmentInputWrapper extends StatelessWidget
{
  final Widget child;
  final bool noAnswerProvided;
  final VoidCallback onNoAnswerPressed;

  const AppAssessmentInputWrapper({ super.key, required this.child, required this.noAnswerProvided,
                                    required this.onNoAnswerPressed });

  @override
  Widget build(BuildContext context)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Expanded(child: child),

        AppNoAnswerButton(
          selected: noAnswerProvided,
          onPressed: onNoAnswerPressed,
        ),
      ],
    );
  }
}
