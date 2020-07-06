import 'dart:convert';

import 'package:builder_app/app/providers/wordpress/model/embed_model.dart';
import 'package:flutter/material.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.titulo,
    this.conteudo,
    this.urlImagem,
    this.urlPost,
  });

  String titulo;
  String conteudo;
  String urlImagem;
  String urlPost;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    EmbedModel embedModel = EmbedModel.fromJson(json);

    return PostModel(
      titulo: json["title"]['rendered'],
      conteudo: json["content"]['rendered'],
      urlImagem: embedModel.embedded?.wpFeaturedmedia[0]?.mediaDetails?.sizes?.medium?.sourceUrl ??
          'https://tanzolymp.com/images/default-non-user-no-photo-1.jpg',
      urlPost: json["link"],
    );
  }

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "conteudo": conteudo,
        "urlImagem": urlImagem,
        "urlPost": urlPost,
      };
}
