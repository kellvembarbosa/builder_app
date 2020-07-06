import 'package:builder_app/app/modules/builder/builder_controller.dart';
import 'package:builder_app/app/providers/wordpress/widgets/wordpress_card_widget.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_internafeed.dart';
import 'package:builder_app/app/providers/wordpress/model/wordpress_model.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_repository.dart';
import 'package:builder_app/app/shared/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'wordpress_controller.dart';

class WordpressPage extends StatefulWidget {
  final List<String> argumentos;
  WordpressPage({Key key, this.argumentos}) : super(key: key);

  @override
  _WordpressPageState createState() => _WordpressPageState();
}

class _WordpressPageState
    extends ModularState<WordpressPage, WordpressController> {
  @override
  void initState() {
    super.initState();
    debugPrint("initState");
    callMethodInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Stack(
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () {
                return controller.loadItems(
                    url: widget.argumentos[0], refresh: true);
              },
              child: IncrementallyLoadingListView(
                  shrinkWrap: false,
                  padding: EdgeInsets.only(top: 16, left: 8, right: 8),
                  hasMore: () => controller.hasMoreItems,
                  itemCount: () => controller.listPosts.length,
                  loadMore: () async {
                    await controller.loadItems(
                        url: widget.argumentos[0], refresh: false);
                  },
                  loadMoreOffsetFromBottom: 2,
                  itemBuilder: (context, index) {
                    var post = controller.listPosts[index];
                    /*if(index < 5){
                      return Container();
                    }else*/
                      return WordPressCardWidget(
                          postModel: post,
                          onTap: () {
                            Modular.to.pushNamed('/internafeed', arguments: post);
                          });
                  }),
            ),
            controller.fetchStatus == FetchStatus.Loading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          width: 30,
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    controller.clearListWp();
    super.dispose();
  }
}
