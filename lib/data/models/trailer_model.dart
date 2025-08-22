class TrailerVideo {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  const TrailerVideo({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });
  static List<TrailerVideo> fetchData(Map<String, dynamic> json) {
    List data = json['results'];
    List<TrailerVideo> result = [];
    for (var value in data) {
      result.add(TrailerVideo.fromJson(value));
    }
    return result;
  }

  factory TrailerVideo.fromJson(Map<String, dynamic> json) {
    return TrailerVideo(
      iso6391: json['iso_639_1'] as String,
      iso31661: json['iso_3166_1'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      official: json['official'] as bool,
      publishedAt: DateTime.parse(json['published_at'] as String),
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso6391,
      'iso_3166_1': iso31661,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'published_at': publishedAt.toIso8601String(),
      'id': id,
    };
  }
}
