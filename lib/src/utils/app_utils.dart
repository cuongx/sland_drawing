import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

class AppUtils {
  AppUtils._();

  static void toast(String? message, {Duration? duration}) {
    if (message == null) return;
    showOverlayNotification((context) {
      return SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primary,
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.normalBold.copyWith(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      );
    }, duration: duration ?? Duration(milliseconds: 2000));
  }

  static const List<String> _themes = ['dark', 'light'];

  static dynamic valueByMode({List<String> themes = _themes, required List<dynamic> values}) {
    try {
      for (int i = 0; i < themes.length; i++) {
        if (AppPrefs.appMode == themes[i]) {
          if (i < values.length)
            return values[i];
          else
            values.first;
        }
      }
      return values.first;
    } catch (e) {
      return values.first;
    }
  }

  static String pathMediaToUrl(String? url) {
    if (url == null || url.startsWith("http")) return url ?? "";
    return "${"AppEndpoint.BASE_UPLOAD_URL"}$url";
  }

  static String convertDateTime2String(DateTime? dateTime, {String format = 'yy-MM-dd'}) {
    if (dateTime == null) return "";
    return DateFormat(format).format(dateTime);
  }

  static DateTime? convertString2DateTime(String? dateTime,
      {String format = "yyyy-MM-ddTHH:mm:ss.SSSZ"}) {
    if (dateTime == null) return null;
    return DateFormat(format).parse(dateTime);
  }

  static String convertString2String(String? dateTime,
      {String inputFormat = "yyyy-MM-ddTHH:mm:ss.SSSZ", String outputFormat = "yyyy-MM-dd"}) {
    if (dateTime == null) return "";
    final input = convertString2DateTime(dateTime, format: inputFormat);
    return convertDateTime2String(input, format: outputFormat);
  }

  static String minimum(int? value) {
    if (value == null) return "00";
    return value < 10 ? "0$value" : "$value";
  }

  static String formatMoneyShort(num money) {
    if (money < 1000) {
      return "$money Đ";
    }
    if (money < 1000000) {
      return "${(money % 1000 == 0 ? money ~/ 1000 : (money / 100))} ${"thousand"}";
    } else if (money < 1000000000) {
      return "${(money % 1000000 == 0 ? money ~/ 1000000 : (money / 1000000))} ${"million"}";
    } else {
      return "${(money % 1000000000 == 0 ? money ~/ 1000000000 : (money / 1000000000))} ${"billion"}";
    }
  }

  static String convertPhoneNumber(String phone, {String code = "+84"}) {
    return '$code${phone.substring(1)}';
  }

  static String showMoney(num money, bool showDecimal) {
    return money / 1000000000 >= 1
        ? "${(money / 1000000000).toStringAsFixed(showDecimal ? 2 : 0)} ${"billion"}"
        : money / 1000000 >= 1
            ? "${(money / 1000000).toStringAsFixed(showDecimal ? 1 : 0)} ${"million"}"
            : (money / 1000 >= 1
                ? "${(money / 1000).toStringAsFixed(0)} ${"thousand"}"
                : "$money đ");
  }
}
