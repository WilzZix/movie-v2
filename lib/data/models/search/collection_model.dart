class Collection {
  final bool adult;
  final String backdropPath;
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String posterPath;

  Collection({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
    );
  }

  Collection copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? name,
    String? originalLanguage,
    String? originalName,
    String? overview,
    String? posterPath,
  }) {
    return Collection(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      name: name ?? this.name,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
    );
  }
}