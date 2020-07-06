import 'package:builder_app/app/shared/remote/remote_controller.dart';
import 'package:flutter/material.dart';
import 'package:builder_app/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  var configs = RemoteController.instance;
  await configs.callRemoteConfigs();

  runApp(ModularApp(module: AppModule()));
}
