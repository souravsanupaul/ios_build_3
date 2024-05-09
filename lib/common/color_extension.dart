import 'package:flutter/material.dart';

class ApplicationColor {
  static bool themeModeDark = true;
  static Color get primaryColor => const Color(0xffFFBB3B);
  static Color get primaryColor2 => const Color(0xffFFA90A);
  static List<Color> get primaryG => [primaryColor, primaryColor2];

  static Color get bgDark => const Color(0xff000000);
  static Color get bgLight => const Color(0xffF5F5F5);
  static Color get bgColor => themeModeDark ? bgDark : bgLight;

  static Color get cardDark => const Color(0xff212121);
  static Color get cardLight => const Color(0xffFFFFFF);
  static Color get cardLightGry => const Color(0xffE8E8E8);

  static Color get tabBGDark => const Color(0xff1A1A1A);
  static Color get tabBGLight => const Color(0xffFFFFFF);

  static Color get textDark => const Color(0xffFFFFFF);
  static Color get textLight => const Color(0xff5A5A5A);
  static Color get text => themeModeDark ? textDark : textLight;

  static Color get textOpacity => (text).withOpacity(0.8);

  static Color get subtextDark => const Color(0xffA2A2A2);
  static Color get subtextLight => const Color(0xffA2A2A2);

  static Color get subText => themeModeDark ? subtextDark : subtextLight;
}
