import 'package:builder_app/app/providers/wordpress/wordpress_controller.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_page.dart';
import 'package:builder_app/app/shared/remote/remote_controller.dart';
import 'package:builder_app/app/shared/util.dart';
import 'package:builder_app/app/shared/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'builder_controller.dart';

class BuilderPage extends StatefulWidget {
  @override
  _BuilderPageState createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  BuilderController controller = Modular.get<BuilderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      drawer: RemoteController.instance.configModel.data.length > 1
          ? RemoteController.instance.configModel.settings.appUserDrawer
              ? DrawerWidget()
              : null
          : null,


      appBar: AppBar(
        title: Observer(builder: (context) {
          return Text(controller.drawerSelected?.title ??
              RemoteController.instance.configModel.settings.appName);
        }),
      ),



      body: Observer(builder: (context) {
        controller.tabSelectedIndex;
        debugPrint("pageView: ${controller.drawerSelected.tabs[controller.tabSelectedIndex]}");
        return controller.provider(controller.drawerSelected.tabs[controller.tabSelectedIndex]);
      }),



      bottomNavigationBar: Observer(builder: (context) {
        return controller.listBottomNavigation.isNotEmpty &&
                controller.listBottomNavigation.length >= 2 &&
                RemoteController
                    .instance.configModel.settings.bottomBarNavigation
            ? Observer(builder: (context) {
                return BottomNavigationBar(
                  items: controller.listBottomNavigation,
                  currentIndex: controller.tabSelectedIndex,
                  onTap: (index) {
                      controller.updateTabSelected(index);
                      //mudar depois pequena gambirra
                      callMethodInitState();
                    },
                );
              })
            : Container(
                height: 0,
                width: 0,
              );
      }),




    );
  }
}
