import 'package:builder_app/app/providers/wordpress/wordpress_controller.dart';
import 'package:builder_app/app/providers/wordpress/model/wordpress_model.dart';
import 'package:builder_app/app/shared/remote/remote_controller.dart';
import 'package:builder_app/app/shared/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';

class WordpressRepository extends Disposable {

  Future<List<PostModel>> fetchPost({@required String url,  int page = 1, int offset = 1, int perPage = 10}) async {
    List<PostModel> listPosts = [];
    WordPressAPI wp =  WordPressAPI(url);

    try {
      debugPrint("loadData $offset");
      var posts = (await wp.getAsync("posts?page=$page&per_page=$perPage&offset=$offset&_embed"))['data'];

      if (offset == 1) {
        listPosts.clear();
      }

      for (var postItem in posts) {
        var post = PostModel.fromJson(postItem);
        listPosts.add(post);
      }
    } catch (exception, stack) {
      print(exception);
      print(stack);
    }
    debugPrint("listPOsts ${listPosts.toString()}");
    return listPosts;
  }

  @override
  void dispose() {
  }

}

/*
class WordpressRepository extends LoadingMoreBase<PostModel> {
  WordPressAPI wp;
  int offset = 1;
  int perPage = 10;
  bool _hasMore = true;
  bool forceRefresh = false;
  
  @override
  bool get hasMore => (_hasMore && length < 30) || forceRefresh;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    offset = offset + 10;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {

    debugPrint("loadData: ${Modular.get<WordpressController>().url}");

    wp = WordPressAPI(Modular.get<WordpressController>().url);

    bool isSuccess = false;
    try {
      //to show loading more clearly, in your app,remove this
      await Future.delayed(Duration(milliseconds: 500));

      debugPrint("loadData $offset");
      var posts = (await wp.getAsync("posts?per_page=$perPage&offset=$offset&_embed"))['data'];

      *//*var post = PostModel.fromJson(results);
      if (offset == 1) {
        this.clear();
      }*//*

      for (var postItem in posts) {

        var post = PostModel.fromJson(postItem);
        if (offset == 1) {
          this.clear();
        }

        if (!this.contains(post) && hasMore) this.add(post);
      }

      _hasMore = posts.length != 0;
      offset = offset+perPage;
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }
}*/
