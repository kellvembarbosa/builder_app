import 'package:builder_app/app/shared/remote/remote_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/util.dart';

class AppWidget extends StatelessWidget {

  ThemeData _themeData = ThemeData(
      primarySwatch:
        MaterialColor(HexColor.fromHex(RemoteController.instance.configModel.settings.corApp).value, getSwatch(HexColor.fromHex(RemoteController.instance.configModel.settings.corApp))));

  ThemeMode getMode() {
    switch(RemoteController.instance.configModel.settings.defaultThemeApp) {
      case "1":
          return ThemeMode.dark;
        break;
      case "2":
          return ThemeMode.light;
        break;
      default:
        return ThemeMode.system;
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: RemoteController.instance.configModel.settings.appName,
      themeMode: getMode(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: HexColor.fromHex(RemoteController.instance.configModel.settings.corApp),
        primarySwatch: MaterialColor(HexColor.fromHex(RemoteController.instance.configModel.settings.corApp).value, getSwatch(HexColor.fromHex(RemoteController.instance.configModel.settings.corApp)))
      ),
      theme: _themeData,
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
