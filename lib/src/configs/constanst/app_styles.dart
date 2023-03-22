import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static const FONT_SIZE_VERY_SMALL = 10.0;
  static const FONT_SIZE_SMALL = 12.0;
  static const FONT_SIZE_MEDIUM_1 = 14.0;
  static const FONT_SIZE_MEDIUM_2 = 16.0;
  static const FONT_SIZE_LARGE = 20.0;
  static double FONT_SIZE_TITLE = 18.0;
  static const TEXT_HEIGHT = 1.2;

  static const DEFAULT_VERY_SMALL = TextStyle(fontSize: FONT_SIZE_VERY_SMALL, height: TEXT_HEIGHT);
  static const DEFAULT_SMALL = TextStyle(fontFamily: "Noto_Sans", height: TEXT_HEIGHT);
  static const DEFAULT_MEDIUM_1 = TextStyle(fontSize: FONT_SIZE_MEDIUM_1, height: TEXT_HEIGHT);
  static const DEFAULT_MEDIUM_2 = TextStyle(fontSize: FONT_SIZE_MEDIUM_2, height: TEXT_HEIGHT);
  static const DEFAULT_LARGE = TextStyle(fontSize: FONT_SIZE_LARGE, height: TEXT_HEIGHT);
  static const DEFAULT_MEDIUM = TextStyle(fontSize: FONT_SIZE_MEDIUM_2, height: TEXT_HEIGHT);

  static final DEFAULT_VERY_SMALL_BOLD = DEFAULT_VERY_SMALL.copyWith(fontWeight: FontWeight.bold);
  static final DEFAULT_SMALL_BOLD = DEFAULT_SMALL.copyWith(fontWeight: FontWeight.bold);
  static final DEFAULT_MEDIUM_1_BOLD = DEFAULT_MEDIUM_1.copyWith(fontWeight: FontWeight.bold);
  static final DEFAULT_MEDIUM_2_BOLD = DEFAULT_MEDIUM_2.copyWith(fontWeight: FontWeight.bold);
  static final DEFAULT_LARGE_BOLD = DEFAULT_LARGE.copyWith(fontWeight: FontWeight.bold);
  static final DEFAULT_MEDIUM_BOLD = DEFAULT_MEDIUM.copyWith(fontWeight: FontWeight.bold);
  static final DEFAULT_TEXT_DRAWER =
      DEFAULT_LARGE.copyWith(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28);
  static TextStyle DEFAULT_TITLE_LARGE = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w900, color: Colors.red, fontFamily: "UTM_HeleveBold");

  static TextStyle DEFAULT_UTM_MEDIUM =
      const TextStyle(fontSize: 13, fontFamily: "UTM_Medium", color: Colors.white);

  static TextStyle DEFAULT_UTM_HELEVE = const TextStyle(fontSize: 13, fontFamily: "UTM_HeleveBold");

  static TextStyle DEFAULT_SAN_ITALIC = const TextStyle(
      fontSize: 15, fontFamily: "Noto_Sans", color: Colors.blue, fontStyle: FontStyle.italic);

  static TextStyle DEFAULT_SAN = const TextStyle(fontSize: 13, fontFamily: "Noto_Sans");

  static TextStyle DEFAULT_SAN_BOLD =
      const TextStyle(fontSize: 13, fontFamily: "Noto_Sans", fontWeight: FontWeight.w900);
}
