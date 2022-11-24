import 'dart:convert';

class Libro {
  Libro({
    required this.id,
   required this.img, 
    required this.name,
    required this.author,

    required this.genre,
    required this.link,
  });

  String id;
    String img;

  String name;
  String author;

  String genre;

  String? link;


  factory Libro.fromJson(String str) =>
      Libro.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Libro.fromMap(Map<String, dynamic> json) => Libro(
        id: json["id"],
        // created: DateTime.parse(json["created"]),
        // updated: DateTime.parse(json["updated"]),
        // collectionId: json["@collectionId"],
        // collectionName: json["@collectionName"],
        //expand: Expand.fromMap(json["@expand"]),
        // alt: json["alt"],
        // comOrg: json["com_Org"],
        name: json["name"],
        author: json["author"],
        // long: json["long"],
        genre: json["genre"],
        // respble: json["respble"],
        img: json["img"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,

        "name": name,
        "author": author,
        "genre": genre,
        "link": link,
        "img": img,

      };
}

class Expand {
  Expand();

  factory Expand.fromJson(String str) => Expand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expand.fromMap(Map<String, dynamic> json) => Expand();

  Map<String, dynamic> toMap() => {};
}
