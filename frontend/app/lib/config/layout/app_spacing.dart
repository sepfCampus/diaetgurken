import 'package:flutter/material.dart';

class AppSpacing
{
  //numbers that are used for margins, paddings, ...
  static const double XXS = 4;
  static const double XS = 8;
  static const double SM = 12;
  static const double MD = 16;
  static const double LG = 20;
  static const double XL = 24;
  static const double XXL = 32;

  //default padding for the whole page
  static const EdgeInsets PAGE_PADDING = EdgeInsets.fromLTRB(20, 18, 20, 24);

  //default padding for dialogues
  static const EdgeInsets DIALOG_PADDING = EdgeInsets.all(20);

  //default padding ifor cards
  static const EdgeInsets CARD_PADDING = EdgeInsets.all(12);

  //default padding for sections
  static const EdgeInsets SECTION_PADDING = EdgeInsets.all(16);

  //default padding for input fields
  static const EdgeInsets INPUT_PADDING = EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  //default spaced boyes
  static const SizedBox SPACED_BOX_H_EXTRA_EXTRA_SMALL = SizedBox(height: XXS);
  static const SizedBox SPACED_BOX_H_EXTRA_SMALL = SizedBox(height: XS);
  static const SizedBox SPACED_BOX_H_SMALL = SizedBox(height: SM);
  static const SizedBox SPACED_BOX_H_MEDIUM = SizedBox(height: MD);
  static const SizedBox SPACED_BOX_H_LARGE = SizedBox(height: LG);
  static const SizedBox SPACED_BOX_H_EXTRA_LARGE = SizedBox(height: XL);
  static const SizedBox SPACED_BOX_H_EXTRA_EXTRA_LARGE = SizedBox(height: XXL);

  static const SizedBox SPACED_BOX_W_EXTRA_EXTRA_SMALL = SizedBox(width: XXS);
  static const SizedBox SPACED_BOX_W_EXTRA_SMALL = SizedBox(width: XS);
  static const SizedBox SPACED_BOX_W_SMALL = SizedBox(width: SM);
  static const SizedBox SPACED_BOX_W_MEDIUM = SizedBox(width: MD);
  static const SizedBox SPACED_BOX_W_LARGE = SizedBox(width: LG);
  static const SizedBox SPACED_BOX_W_EXTRA_LARGE = SizedBox(width: XL);
  static const SizedBox SPACED_BOX_W_EXTRA_EXTRA_LARGE = SizedBox(width: XXL);
}
