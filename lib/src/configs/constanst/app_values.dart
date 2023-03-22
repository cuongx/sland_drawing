import 'package:get/get.dart';

class AppValues {
  static const String APP_NAME = "BĐS SLAND";
  static const String DEFAULT_PROVINCE_NAME = "Tỉnh Thừa Thiên Huế";
  static const DEFAULT_LAT = 16.4571201;
  static const DEFAULT_LONG = 107.5876121;
  static const DEFAULT_PROVINCE_ID = 46;
  static const bool IS_GEO = false;

  static const double INPUT_FORM_HEIGHT = 55;
  static const double SETTING_ITEM_HEIGHT = 55;
  static const double DEFAULT_LATITUDE = 16.464028528203347;
  static const double DEFAULT_LONGITUDE = 107.5879870528346;
  static const double originalWidth = 360; // width device dùng để xây dựng app
  static const double originalHeight = 640; // height device dùng để xây dựng app

  static const double PADDING_NORMAL = 16.0;
  static const double PADDING_HORIZONTAL = 16.0;
  static const double PADDING_TOP = 24.0;
  static const double PADDING_BOTTOM = 48.0;

  static double? scaleWidth;
  static double? scaleHeight;

  void init() {
    scaleWidth = Get.width / originalWidth;
    scaleHeight = Get.height / originalHeight;
  }

  static double? scaleGeneral = scaleWidth! < scaleHeight! ? scaleWidth : scaleHeight;
  static double? scaleVertical = scaleHeight;
  static double? scaleHorizontal = scaleWidth;
}
