import 'package:builder_app/app/providers/wordpress/wordpress_internafeed.dart';
import 'package:dio/dio.dart';
import 'providers/wordpress/wordpress_repository.dart';
import 'providers/wordpress/wordpress_controller.dart';
import 'package:builder_app/app/modules/builder/builder_module.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:builder_app/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => WordpressRepository()),
        Bind((i) => WordpressController()),
        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: BuilderModule()),
        Router('/internafeed', child: (_, args) => WordPressInternaFeed(postModel: args.data)),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
