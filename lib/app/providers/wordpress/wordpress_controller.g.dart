// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordpress_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WordpressController on _WordpressControllerBase, Store {
  Computed<List<PostModel>> _$listPostsComputed;

  @override
  List<PostModel> get listPosts =>
      (_$listPostsComputed ??= Computed<List<PostModel>>(() => super.listPosts,
              name: '_WordpressControllerBase.listPosts'))
          .value;

  final _$fetchStatusAtom = Atom(name: '_WordpressControllerBase.fetchStatus');

  @override
  FetchStatus get fetchStatus {
    _$fetchStatusAtom.reportRead();
    return super.fetchStatus;
  }

  @override
  set fetchStatus(FetchStatus value) {
    _$fetchStatusAtom.reportWrite(value, super.fetchStatus, () {
      super.fetchStatus = value;
    });
  }

  final _$hasMoreItemsAtom =
      Atom(name: '_WordpressControllerBase.hasMoreItems');

  @override
  bool get hasMoreItems {
    _$hasMoreItemsAtom.reportRead();
    return super.hasMoreItems;
  }

  @override
  set hasMoreItems(bool value) {
    _$hasMoreItemsAtom.reportWrite(value, super.hasMoreItems, () {
      super.hasMoreItems = value;
    });
  }

  final _$_listPostsAtom = Atom(name: '_WordpressControllerBase._listPosts');

  @override
  ObservableList<PostModel> get _listPosts {
    _$_listPostsAtom.reportRead();
    return super._listPosts;
  }

  @override
  set _listPosts(ObservableList<PostModel> value) {
    _$_listPostsAtom.reportWrite(value, super._listPosts, () {
      super._listPosts = value;
    });
  }

  final _$loadItemsAsyncAction =
      AsyncAction('_WordpressControllerBase.loadItems');

  @override
  Future<void> loadItems({@required String url, dynamic refresh = false}) {
    return _$loadItemsAsyncAction
        .run(() => super.loadItems(url: url, refresh: refresh));
  }

  final _$_WordpressControllerBaseActionController =
      ActionController(name: '_WordpressControllerBase');

  @override
  dynamic clearListWp() {
    final _$actionInfo = _$_WordpressControllerBaseActionController.startAction(
        name: '_WordpressControllerBase.clearListWp');
    try {
      return super.clearListWp();
    } finally {
      _$_WordpressControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchStatus: ${fetchStatus},
hasMoreItems: ${hasMoreItems},
listPosts: ${listPosts}
    ''';
  }
}
