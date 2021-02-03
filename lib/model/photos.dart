class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}


class Radata {
  Radata({
    this.data,
  });

  List<Radio> data;

  factory Radata.fromJson(Map<String, dynamic> json) => Radata(
    data: List<Radio>.from(json["data"].map((x) => Radio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Radio {
  Radio({
    this.id,
    this.name,
    this.imageurl,
    this.website,
    this.listenlive,
  });

  String id;
  String name;
  String imageurl;
  String website;
  String listenlive;

  factory Radio.fromJson(Map<String, dynamic> json) => Radio(
    id: json["_id"],
    name: json["name"],
    imageurl: json["imageurl"],
    website: json["website"],
    listenlive: json["listenlive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "imageurl": imageurl,
    "website": website,
    "listenlive": listenlive,
  };
}