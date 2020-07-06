import 'package:builder_app/app/providers/wordpress/model/wordpress_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;

class WordPressCardWidget extends StatelessWidget {
  final PostModel postModel;
  final Function onTap;

  const WordPressCardWidget({Key key, this.postModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 200),
        child: Column(
          children: <Widget>[
            Hero(
              tag: postModel.urlPost,
              child: Container(
                height: 200,
                width: double.maxFinite,
                margin: EdgeInsets.only(bottom: 0, left: 5.3, right: 5.3),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(postModel.urlImagem)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness ==
                          Brightness.light
                          ? Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.5)
                          : Theme.of(context).cardColor,
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16, left: 6, right: 6),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness ==
                            Brightness.light
                        ? Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.5)
                        : Theme.of(context).cardColor,
                    spreadRadius: 0,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(html2md.convert(postModel.titulo),
                    maxLines: 2,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
