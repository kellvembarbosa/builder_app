import 'package:builder_app/app/modules/builder/builder_controller.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_controller.dart';
import 'package:builder_app/app/shared/remote/remote_controller.dart';
import 'package:builder_app/app/shared/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<Widget> _itemsDrawer = <Widget>[];
  initDrawer(BuildContext context){
    _itemsDrawer.add(
      ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 150
      ),
      child: DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(RemoteController.instance.configModel.settings.appName),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(RemoteController.instance.configModel.settings.slogan),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: HexColor.fromHex(RemoteController.instance.configModel.settings.corApp),
        ),
      ),
    ));

    var drawerItems = RemoteController.instance.configModel.data;

    drawerItems.forEach((item) {
      _itemsDrawer.add(
        ListTile(
          title: Text(item.title),
          leading: item.drawable.isEmpty ? Icon(Icons.format_align_justify) : Container(),
          onTap: () {
            Modular.get<BuilderController>().updateDrawerSelected(item);
            //mudar depois pequena gambirra
            callMethodInitState();
            Navigator.pop(context);
          },
        ));
    });
  }

  @override
  void initState() {
    super.initState();
    _itemsDrawer.clear();
    initDrawer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _itemsDrawer,
      ),
    );
  }
}
