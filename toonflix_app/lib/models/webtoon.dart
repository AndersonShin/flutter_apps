class WebToon {
  late final String title, thumb, id;

  WebToon.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        thumb = json["thumb"],
        id = json["id"];
}
