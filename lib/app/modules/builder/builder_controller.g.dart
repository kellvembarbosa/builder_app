// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'builder_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BuilderController on _BuilderControllerBase, Store {
  Computed<List<BottomNavigationBarItem>> _$listBottomNavigationComputed;

  @override
  List<BottomNavigationBarItem> get listBottomNavigation =>
      (_$listBottomNavigationComputed ??=
              Computed<List<BottomNavigationBarItem>>(
                  () => super.listBottomNavigation,
                  name: '_BuilderControllerBase.listBottomNavigation'))
          .value;
  Computed<List<Widget>> _$listPagesComputed;

  @override
  List<Widget> get listPages =>
      (_$listPagesComputed ??= Computed<List<Widget>>(() => super.listPages,
              name: '_BuilderControllerBase.listPages'))
          .value;

  final _$pageControllerAtom =
      Atom(name: '_BuilderControllerBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$_listPagesAtom = Atom(name: '_BuilderControllerBase._listPages');

  @override
  ObservableList<Widget> get _listPages {
    _$_listPagesAtom.reportRead();
    return super._listPages;
  }

  @override
  set _listPages(ObservableList<Widget> value) {
    _$_listPagesAtom.reportWrite(value, super._listPages, () {
      super._listPages = value;
    });
  }

  final _$_listBottomNavigationAtom =
      Atom(name: '_BuilderControllerBase._listBottomNavigation');

  @override
  ObservableList<BottomNavigationBarItem> get _listBottomNavigation {
    _$_listBottomNavigationAtom.reportRead();
    return super._listBottomNavigation;
  }

  @override
  set _listBottomNavigation(ObservableList<BottomNavigationBarItem> value) {
    _$_listBottomNavigationAtom.reportWrite(value, super._listBottomNavigation,
        () {
      super._listBottomNavigation = value;
    });
  }

  final _$drawerSelectedAtom =
      Atom(name: '_BuilderControllerBase.drawerSelected');

  @override
  Datum get drawerSelected {
    _$drawerSelectedAtom.reportRead();
    return super.drawerSelected;
  }

  @override
  set drawerSelected(Datum value) {
    _$drawerSelectedAtom.reportWrite(value, super.drawerSelected, () {
      super.drawerSelected = value;
    });
  }

  final _$tabSelectedIndexAtom =
      Atom(name: '_BuilderControllerBase.tabSelectedIndex');

  @override
  int get tabSelectedIndex {
    _$tabSelectedIndexAtom.reportRead();
    return super.tabSelectedIndex;
  }

  @override
  set tabSelectedIndex(int value) {
    _$tabSelectedIndexAtom.reportWrite(value, super.tabSelectedIndex, () {
      super.tabSelectedIndex = value;
    });
  }

  final _$_BuilderControllerBaseActionController =
      ActionController(name: '_BuilderControllerBase');

  @override
  dynamic addPage(Widget nWidget) {
    final _$actionInfo = _$_BuilderControllerBaseActionController.startAction(
        name: '_BuilderControllerBase.addPage');
    try {
      return super.addPage(nWidget);
    } finally {
      _$_BuilderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateDrawerSelected(Datum nDrawer) {
    final _$actionInfo = _$_BuilderControllerBaseActionController.startAction(
        name: '_BuilderControllerBase.updateDrawerSelected');
    try {
      return super.updateDrawerSelected(nDrawer);
    } finally {
      _$_BuilderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateTabSelected(int nTab) {
    final _$actionInfo = _$_BuilderControllerBaseActionController.startAction(
        name: '_BuilderControllerBase.updateTabSelected');
    try {
      return super.updateTabSelected(nTab);
    } finally {
      _$_BuilderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageController: ${pageController},
drawerSelected: ${drawerSelected},
tabSelectedIndex: ${tabSelectedIndex},
listBottomNavigation: ${listBottomNavigation},
listPages: ${listPages}
    ''';
  }
}
