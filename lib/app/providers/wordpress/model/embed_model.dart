// To parse this JSON data, do
//
//     final embedModel = embedModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

EmbedModel embedModelFromJson(String str) =>
    EmbedModel.fromJson(json.decode(str));

String embedModelToJson(EmbedModel data) => json.encode(data.toJson());

class EmbedModel {
  EmbedModel({
    this.embedded,
  });

  Embedded embedded;

  factory EmbedModel.fromJson(Map<String, dynamic> json) => EmbedModel(
        embedded: Embedded.fromJson(json != null ?  json["_embedded"] : null),
      );

  Map<String, dynamic> toJson() => {
        "_embedded": embedded.toJson(),
      };
}

class Embedded {
  Embedded({
    this.wpFeaturedmedia,
  });

  List<WpFeaturedmedia> wpFeaturedmedia;

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        wpFeaturedmedia: List<WpFeaturedmedia>.from(
            json != null ? json["wp:featuredmedia"].map((x) => WpFeaturedmedia.fromJson(x)) : null),
      );

  Map<String, dynamic> toJson() => {
        "wp:featuredmedia":
            List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
      };
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    this.mediaDetails,
  });

  MediaDetails mediaDetails;

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) =>
      WpFeaturedmedia(
          mediaDetails: MediaDetails.fromJson(json != null ? json["media_details"] : null));

  Map<String, dynamic> toJson() => {"media_details": mediaDetails.toJson()};
}

class MediaDetails {
  MediaDetails({
    this.sizes,
  });

  Sizes sizes;

  factory MediaDetails.fromJson(Map<String, dynamic> json) => MediaDetails(
        sizes: Sizes.fromJson(json != null ? json["sizes"] : null),
      );

  Map<String, dynamic> toJson() => {
        "sizes": sizes.toJson(),
      };
}

class Sizes {
  Sizes({
    this.medium,
  });

  The640X360 medium;

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        medium: The640X360.fromJson(json != null ? json["medium"] : null),
      );

  Map<String, dynamic> toJson() => {
        "medium": medium.toJson(),
      };
}

class The640X360 {
  The640X360({
    this.sourceUrl,
  });

  String sourceUrl;

  factory The640X360.fromJson(Map<String, dynamic> json) {
    debugPrint("source_url: ${json.toString()}");
    return The640X360(
      sourceUrl: json != null ? json["source_url"] : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "source_url": sourceUrl,
      };
}
