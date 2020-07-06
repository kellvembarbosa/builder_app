import 'package:builder_app/app/modules/builder/builder_controller.dart';
import 'package:builder_app/app/providers/wordpress/widgets/wordpress_card_widget.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_internafeed.dart';
import 'package:builder_app/app/providers/wordpress/model/wordpress_model.dart';
import 'package:builder_app/app/providers/wordpress/wordpress_repository.dart';
import 'package:builder_app/app/shared/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'wordpress_controller.dart';

class WordpressPage extends StatefulWidget {
  final List<String> argumentos;
  WordpressPage({Key key, this.argumentos}) : super(key: key);

  @override
  _WordpressPageState createState() => _WordpressPageState();
}

class _WordpressPageState
    extends ModularState<WordpressPage, WordpressController> {
  //var scrollInfo = ScrollController();

  List<PostModel> listSlider = [];

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
        controller.listPosts;
        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!controller.isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            controller.loadItems(
                                url: widget.argumentos[0], refresh: false);
                            controller.updateisLoading(true);
                          }
                          return;
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                            itemCount: controller.listPosts.length,
                            itemBuilder: (context, index) {
                              var post = controller.listPosts[index];
                              if(index == 0 && listSlider.length == 0 || index <= 5 && listSlider.length > 0 ){
                                  listSlider.add(post);
                                  if(listSlider.length > 0 && index == 5)
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 16),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: listSlider.length,
                                        itemBuilder: (_, context){
                                          return Container(color: Colors.red, height: 200, width: 200,);
                                      }),
                                    );
                                  return Container();
                              }else
                                return WordPressCardWidget(
                                    postModel: post,
                                    onTap: () {
                                      Modular.to
                                          .pushNamed('/internafeed', arguments: post);
                                    });
                            }))),
              ],
            ),
            controller.isLoading ? Column(
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
            )
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
