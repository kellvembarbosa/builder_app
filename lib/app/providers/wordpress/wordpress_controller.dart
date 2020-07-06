import 'package:builder_app/app/providers/wordpress/model/wordpress_model.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_repository.dart';
import 'package:builder_app/app/shared/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'wordpress_controller.g.dart';

class WordpressController = _WordpressControllerBase with _$WordpressController;

abstract class _WordpressControllerBase with Store {

  int _perPage  = 10;
  int _page     = 1;

  WordpressRepository _wordpressRepository = Modular.get();

  @observable
  FetchStatus fetchStatus = FetchStatus.Loading;

  @observable
  bool hasMoreItems = true;

  @observable
  ObservableList<PostModel> _listPosts = ObservableList<PostModel>.of([]);

  @computed
  List<PostModel> get listPosts => _listPosts.asObservable();

  @action
  clearListWp() => _listPosts.clear();

  @action
  Future<void> loadItems({@required String url, refresh = false}) async {
    fetchStatus = FetchStatus.Loading;

    if(refresh){
      _listPosts     =   ObservableList<PostModel>.of([]);
      debugPrint("listItems refresh: ${_listPosts.length}");
      hasMoreItems  =   true;
    }

    if(_listPosts.isNotEmpty){
      _page++;
      List<PostModel> nListPosts = await _wordpressRepository.fetchPost(url: url, page: _page, offset: _listPosts.length, perPage: _perPage);
      if(nListPosts.isNotEmpty){
        _listPosts.addAll(nListPosts);
        if(nListPosts.length < (_perPage - 1)){
          hasMoreItems = false;
        }
        fetchStatus = FetchStatus.Completed;
      }else{
        fetchStatus = FetchStatus.NoMoreResults;
        hasMoreItems = false;
      }
    }else{
      List<PostModel> nList = await _wordpressRepository.fetchPost(url: url);
      _listPosts = nList.asObservable();
      debugPrint("else loadItems(); ----> length list: ${_listPosts.length}");

      if(_listPosts.isEmpty){
        debugPrint("else loadItems(); ----> list: isEmpty");
        fetchStatus = FetchStatus.NoResult;
        hasMoreItems = false;
        return;
      }

      if(_listPosts.isNotEmpty && _listPosts.length < (_perPage - 1)){
        debugPrint("else  loadItems(); ----> list: isNotEmpty");
        hasMoreItems = false;
        fetchStatus = FetchStatus.NoMoreResults;
        return;
      }
      fetchStatus = FetchStatus.Completed;

    }
  }
}
