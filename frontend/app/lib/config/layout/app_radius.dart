import 'package:flutter/material.dart';

class AppRadius
{
  //border radius values
  static const double XS = 2;
  static const double SM = 4;
  static const double MD = 6;
  static const double LG = 8;
  static const double XL = 12;

  static const BorderRadius BORDER_RADIUS_EXTRA_SMALL = BorderRadius.all(Radius.circular(XS));
  static const BorderRadius BORDER_RADIUS_SMALL = BorderRadius.all(Radius.circular(SM));
  static const BorderRadius BORDER_RADIUS_MEDIUM = BorderRadius.all(Radius.circular(MD));
  static const BorderRadius BORDER_RADIUS_LARGE = BorderRadius.all(Radius.circular(LG));
  static const BorderRadius BORDER_RADIUS_EXTRA_LARGE = BorderRadius.all(Radius.circular(XL));
}
