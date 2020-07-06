import 'package:builder_app/app/providers/wordpress/model/wordpress_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:html2md/html2md.dart' as html2md;

class WordPressInternaFeed extends StatefulWidget {
  final PostModel postModel;

  const WordPressInternaFeed({Key key, this.postModel}) : super(key: key);
  @override
  _WordPressInternaFeedState createState() => _WordPressInternaFeedState();
}

class _WordPressInternaFeedState extends State<WordPressInternaFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(widget.postModel.titulo)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                height: 0,
                width: 0,
              ),
              background: Hero(
                tag: widget.postModel.urlPost,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.postModel.urlImagem,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(html2md.convert(widget.postModel.titulo),
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Container(child: HtmlView(data: widget.postModel.conteudo, scrollable: false,)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
