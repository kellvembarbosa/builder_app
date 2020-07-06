
class TabConfig {
  TabConfig({
    this.title,
    this.image,
    this.provider,
    this.arguments,
  });

  String title;
  String image;
  String provider;
  List<String> arguments;

  factory TabConfig.fromJson(Map<String, dynamic> json) => TabConfig(
    title: json["title"],
    image: json["image"],
    provider: json["provider"],
    arguments: List<String>.from(json["arguments"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "provider": provider,
    "arguments": List<dynamic>.from(arguments.map((x) => x)),
  };
}