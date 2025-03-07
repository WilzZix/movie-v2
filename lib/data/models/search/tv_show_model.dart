class TvShow {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  const TvShow({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids']),
        id: json['id'],
        originCountry: List<String>.from(json['origin_country']),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: (json['popularity'] as num).toDouble(),
        posterPath: json['poster_path'],
        firstAirDate: json['first_air_date'],
        name: json['name'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        voteCount: json['vote_count'],
      );

  TvShow copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    String? firstAirDate,
    String? name,
    double? voteAverage,
    int? voteCount,
  }) {
    return TvShow(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      name: name ?? this.name,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}
