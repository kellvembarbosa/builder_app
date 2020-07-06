import 'builder_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'builder_page.dart';

class BuilderModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => BuilderController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => BuilderPage()),
      ];

  static Inject get to => Inject<BuilderModule>.of();
}
