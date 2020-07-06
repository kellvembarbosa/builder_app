// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

import 'package:builder_app/app/shared/models/tab_model.dart';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.settings,
    this.data,
  });

  Settings settings;
  List<Datum> data;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    settings: Settings.fromJson(json["settings"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.title,
    this.drawable,
    this.submenu,
    this.tabs,
  });

  String title;
  String drawable;
  String submenu;
  List<TabConfig> tabs;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    drawable: json["drawable"],
    submenu: json["submenu"],
    tabs: List<TabConfig>.from(json["tabs"].map((x) => TabConfig.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "drawable": drawable,
    "submenu": submenu,
    "tabs": List<dynamic>.from(tabs.map((x) => x.toJson())),
  };
}

class Settings {
  Settings({
    this.tempoCache,
    this.versaoId,
    this.corApp,
    this.corAccent,
    this.defaultThemeApp,
    this.appUserDrawer,
    this.bottomBarNavigation,
    this.admobOrFace,
    this.anuncioSplash,
    this.admobInterstitialId,
    this.admobBannerId,
    this.faceInterstitialId,
    this.faceBannerId,
    this.faceBannerIdRetangulo,
    this.openRssExtenal,
    this.slogan,
    this.template,
    this.pacote,
    this.icon,
    this.onesignalAppId,
    this.appName,
  });

  String tempoCache;
  int versaoId;
  String corApp;
  String corAccent;
  String defaultThemeApp;
  bool appUserDrawer;
  bool bottomBarNavigation;
  bool admobOrFace;
  bool anuncioSplash;
  String admobInterstitialId;
  String admobBannerId;
  String faceInterstitialId;
  String faceBannerId;
  String faceBannerIdRetangulo;
  bool openRssExtenal;
  String slogan;
  String template;
  String pacote;
  String icon;
  String onesignalAppId;
  String appName;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    tempoCache: json["tempo_cache"],
    versaoId: json["versao_id"],
    corApp: json["cor_app"],
    corAccent: json["cor_accent"],
    defaultThemeApp: json["default_theme_app"],
    appUserDrawer: json["app_user_drawer"],
    bottomBarNavigation: json["bottom_bar_navigation"],
    admobOrFace: json["admob_or_face"],
    anuncioSplash: json["anuncio_splash"],
    admobInterstitialId: json["admob_interstitial_id"],
    admobBannerId: json["admob_banner_id"],
    faceInterstitialId: json["face_interstitial_id"],
    faceBannerId: json["face_banner_id"],
    faceBannerIdRetangulo: json["face_banner_id_retangulo"],
    openRssExtenal: json["open_rss_extenal"],
    slogan: json["slogan"],
    template: json["template"],
    pacote: json["pacote"],
    icon: json["icon"],
    onesignalAppId: json["onesignal_app_id"],
    appName: json["app_name"],
  );

  Map<String, dynamic> toJson() => {
    "tempo_cache": tempoCache,
    "versao_id": versaoId,
    "cor_app": corApp,
    "cor_accent": corAccent,
    "default_theme_app": defaultThemeApp,
    "app_user_drawer": appUserDrawer,
    "bottom_bar_navigation": bottomBarNavigation,
    "admob_or_face": admobOrFace,
    "anuncio_splash": anuncioSplash,
    "admob_interstitial_id": admobInterstitialId,
    "admob_banner_id": admobBannerId,
    "face_interstitial_id": faceInterstitialId,
    "face_banner_id": faceBannerId,
    "face_banner_id_retangulo": faceBannerIdRetangulo,
    "open_rss_extenal": openRssExtenal,
    "slogan": slogan,
    "template": template,
    "pacote": pacote,
    "icon": icon,
    "onesignal_app_id": onesignalAppId,
    "app_name": appName,
  };
}
