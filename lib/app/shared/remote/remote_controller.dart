import 'package:builder_app/app/shared/constants.dart';
import 'package:builder_app/app/shared/models/config_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RemoteController {
  int _appId;
  int _versionApp;
  Dio dio;

  ConfigModel configModel;

  static final RemoteController _singleton = new RemoteController._internal();

  RemoteController._internal(){
    _appId = 512;
    _versionApp = 2;
    dio = Dio();
  }

  static RemoteController get instance => _singleton;

  Future<ConfigModel> callRemoteConfigs() async {
    String url = "$URL_BASE/wp-json/configs/v${_versionApp.toString()}/${_appId.toString()}";
    debugPrint("url =======> $url");

    var configsRemote = await dio.get(url);
    configModel = ConfigModel.fromJson(configsRemote.data);
    return configModel;
  }
}