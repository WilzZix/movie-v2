class PersonDetailModel {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  final String birthday;
  final String? deathday;
  final int gender;
  final String? homepage;
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String placeOfBirth;
  final double popularity;
  final String? profilePath;

  const PersonDetailModel({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    this.deathday,
    required this.gender,
    this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    this.profilePath,
  });

  factory PersonDetailModel.fromJson(Map<String, dynamic> json) {
    return PersonDetailModel(
      adult: json['adult'] ?? false,
      alsoKnownAs: List<String>.from(json['also_known_as'] ?? []),
      biography: json['biography'] ?? '',
      birthday: json['birthday'] ?? '',
      deathday: json['deathday'],
      gender: json['gender'] ?? 0,
      homepage: json['homepage'],
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'] ?? '',
      knownForDepartment: json['known_for_department'] ?? '',
      name: json['name'] ?? '',
      placeOfBirth: json['place_of_birth'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'also_known_as': alsoKnownAs,
      'biography': biography,
      'birthday': birthday,
      'deathday': deathday,
      'gender': gender,
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'known_for_department': knownForDepartment,
      'name': name,
      'place_of_birth': placeOfBirth,
      'popularity': popularity,
      'profile_path': profilePath,
    };
  }
}
