import 'package:builder_app/app/modules/builder/builder_controller.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

enum Provider { NF, WP, RSS, YT, WEBVIEW, URL }

Provider convertToProvider(String provider) {
  debugPrint("provider by api: $provider");
  switch (provider) {
    case "wp":
        return Provider.WP;
      break;
    case "url":
        return Provider.URL;
      break;
    case "rss":
        return Provider.RSS;
      break;
    case "webview":
        return Provider.WEBVIEW;
      break;
    case "yt":
        return Provider.YT;
      break;
    default:
      debugPrint("Not implemented");
      return Provider.NF;
  }
}

callMethodInitState() {
  switch (convertToProvider(Modular.get<BuilderController>()
      .drawerSelected
      .tabs[Modular.get<BuilderController>().tabSelectedIndex]
      .provider)) {
    case Provider.RSS:
        return Container();
      break;
    case Provider.URL:
        return Container();
      break;
    case Provider.WP:
      Modular.get<WordpressController>().clearListWp();
      Modular.get<WordpressController>().loadItems(
          url: Modular.get<BuilderController>()
              .drawerSelected
              .tabs[Modular.get<BuilderController>().tabSelectedIndex]
              .arguments[0]);
      break;
    default:
      debugPrint("Item não possui metodos para iniciar");
  }
}


enum FetchStatus { Loading, Failed, Completed, NoResult, NoMoreResults }
