import 'package:builder_app/app/providers/wordpress/wordpress_page.dart';
import 'package:builder_app/app/shared/models/config_model.dart';
import 'package:builder_app/app/shared/models/tab_model.dart';
import 'package:builder_app/app/shared/remote/remote_controller.dart';
import 'package:builder_app/app/shared/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'builder_controller.g.dart';

class BuilderController = _BuilderControllerBase with _$BuilderController;

abstract class _BuilderControllerBase with Store {
  _BuilderControllerBase() {
    if (drawerSelected == null &&
        RemoteController?.instance?.configModel?.data?.length != 0) {
      updateDrawerSelected(RemoteController.instance.configModel.data[0]);
      debugPrint("_BuilderControllerBase()");
    }
  }

  @observable
  PageController pageController = PageController();
  @observable
  ObservableList<Widget> _listPages = ObservableList<Widget>.of([]);
  @observable
  ObservableList<BottomNavigationBarItem> _listBottomNavigation =
      ObservableList<BottomNavigationBarItem>.of([]);
  @observable
  Datum drawerSelected;
  @observable
  int tabSelectedIndex = 0;

  @computed
  List<BottomNavigationBarItem> get listBottomNavigation =>
      _listBottomNavigation.asObservable();
  @computed
  List<Widget> get listPages => _listPages.asObservable();

  @action
  addPage(Widget nWidget) {
    _listPages.add(nWidget);
  }

  @action
  updateDrawerSelected(Datum nDrawer) {
    _listPages.clear();
    _listBottomNavigation.clear();

    drawerSelected = nDrawer;
    tabSelectedIndex = 0;

    drawerSelected.tabs.forEach((tab){

      //_listPages.add(provider(tab));
      _listBottomNavigation.add(
          BottomNavigationBarItem(
            title: Text(tab.title),
            icon: tab.image.isEmpty
                ? Icon(Icons.format_align_justify)
                : Container()
          )
      );
    });

  }

  @action
  updateTabSelected(int nTab) {
    tabSelectedIndex = nTab;
  }

  Widget provider(TabConfig tab) {
    if (drawerSelected == null)
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else
      switch (convertToProvider(tab.provider)) {
        case Provider.WP:
          debugPrint("provider: ${tab.title}");
          return WordpressPage(argumentos: tab.arguments);
          break;
        default:
          return Container(
            child: Center(child: Text(tab.title)),
          );
      }
  }
}
