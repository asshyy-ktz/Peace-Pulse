// To parse this JSON data, do
//
//     final moviesMain = moviesMainFromJson(jsonString);
// API   https://mocki.io/v1/78f4c192-75b6-407b-a3b9-1771b20566fc

import 'dart:convert';

// AudiosMain moviesMainFromJson(String str) =>
//     AudiosMain.fromJson(json.decode(str));

// String moviesMainToJson(AudiosMain data) => json.encode(data.toJson());

class AudiosMain {
  AudiosMain({
    this.audios,
  });

  List<MyAudio>? audios;

  static List<MyAudio> sampleFromJson(List<dynamic> str) {
    return str.map((item) => MyAudio.fromJson(item)).toList();
  }

  String sampleToJson(List<MyAudio> data) {
    final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
  }

//   factory AudiosMain.fromJson(Map<String, dynamic> json) => AudiosMain(
//         audios: json["movies"] == null
//             ? null
//             : List<MyAudio>.from(
//                 json["movies"].map((x) => MyAudio.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "movies": audios == null
//             ? null
//             : List<dynamic>.from(audios!.map((x) => x.toJson())),
//       };
}

// class MyAudio {
//   MyAudio({
//     this.id,
//     this.title,
//     this.description,
//     this.imageUrl,
//     this.audioUrl,
//     this.imageRatio,
//     this.audioLength,
//   });

//   String? id;
//   String? title;
//   String? description;
//   String? imageUrl;
//   String? audioUrl;
//   int? imageRatio;
//   int? audioLength;
//   factory MyAudio.fromJson(Map<String, dynamic> json) => MyAudio(
//         id: json["id"] == null ? null : json["id"],
//         title: json["title"] == null ? null : json["title"],
//         description: json["description"] == null ? null : json["description"],
//         imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
//         audioUrl: json["imageUrl"] == null ? null : json["audioUrl"],
//         imageRatio: json["imageUrl"] == null ? null : json["imageRatio"],
//         audioLength: json["audioLength"] == null ? null : json["audioLength"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "title": title == null ? null : title,
//         "description": description == null ? null : description,
//         "imageUrl": imageUrl == null ? null : imageUrl,
//         "audioUrl": audioUrl == null ? null : audioUrl,
//         "imageRatio": imageRatio == null ? null : imageRatio,
//         "audioLength": audioLength == null ? null : audioLength,
//       };
// }

class MyAudio {
  final String id;
  final String imageUrl;
  final String audioUrl;
  final String title;
  final String description;
  final double imageRatio;
  final int audioLength;

  MyAudio({
    required this.id,
    required this.imageUrl,
    required this.audioUrl,
    required this.title,
    required this.description,
    required this.imageRatio,
    required this.audioLength,
  });

  factory MyAudio.fromJson(Map<String, dynamic> json) {
    return MyAudio(
      id: json['id'],
      imageUrl: json['imageUrl'],
      audioUrl: json['audioUrl'],
      title: json['title'],
      description: json['description'],
      imageRatio: json['imageRatio'],
      audioLength: json['audioLength'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "audioUrl": audioUrl,
        "title": title,
        "description": description,
        "imageRatio": imageRatio,
        "audioLength": audioLength,
      };
}

// enum OriginalTitle { EMPTY, ANNIHILATION, A_WRINKLE_IN_TIME, THE_LEISURE_SEEKER, CE_QUI_NOUS_LIE }

/*final originalTitleValues = EnumValues({
  "Annihilation": OriginalTitle.ANNIHILATION,
  "A Wrinkle in Time": OriginalTitle.A_WRINKLE_IN_TIME,
  "Ce qui nous lie": OriginalTitle.CE_QUI_NOUS_LIE,
  "": OriginalTitle.EMPTY,
  "The Leisure Seeker": OriginalTitle.THE_LEISURE_SEEKER
});*/

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
