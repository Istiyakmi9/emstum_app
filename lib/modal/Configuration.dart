import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Configuration {
  static double height = 0;
  static double width = 0;
  static bool isAndroid = true;
  static double _pagePadding = 18;
  static double fieldGap = 12;
  static String StringDefault = "";
  static const String defaultImgUrl = "assets/images/profile.png";
  static const String applicationHeader = "Hiring Bell";
  static const String success = "#93A836";
  static const String fail = "#99150e";
  static const String warning = "#edc34e";
  static const String deepWarning = "#ab6d16";
  static const String info = "#48d8d1";
  static const String dark = "#000000";
  static const String fade = "#eeeeee";
  static const String lightDark = "#888888";

  static void setPagePadding(double value) {
    _pagePadding = value;
  }

  static double get getLoaderSize => Configuration.width * 0.04;

  static double get pagePadding => _pagePadding;

  static Color ColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    return Color(int.parse("0x000000"));
  }

  static bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static String replaceToNotNull(dynamic value) {
    String returnValue = "NA";
    if (value != null && value != "") {
      returnValue = value.toString().trim();
    }
    return returnValue;
  }

  static Widget getImage(String imageUrl) {
    CachedNetworkImage image;
    try {
      if (imageUrl != "") {
        image = CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
        return image;
      } else {
        return Image.network(
            "https://static.thenounproject.com/png/4381137-200.png");
      }
    } catch (e) {
      return Image.network(
          "https://static.thenounproject.com/png/4381137-200.png");
    }
  }
}
