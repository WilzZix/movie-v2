import 'package:equatable/equatable.dart';

enum MediaType { movie, person, tv, collection, all }

class SearchArguments with EquatableMixin {
  const SearchArguments({
    this.mediaType,
    this.genre,
    this.country,
    this.releaseYear,
    this.sortedBy,
  });

  final MediaType? mediaType;
  final int? genre;
  final String? releaseYear;
  final String? country;
  final String? sortedBy;

  SearchArguments copyWith({
    MediaType? mediaType,
    int? genre,
    String? releaseYear,
    String? country,
    String? sortedBy,
  }) {
    return SearchArguments(
      mediaType: mediaType ?? this.mediaType,
      genre: genre ?? this.genre,
      releaseYear: releaseYear ?? this.releaseYear,
      country: country ?? this.country,
      sortedBy: sortedBy ?? this.sortedBy,
    );
  }

  bool get isFilterSet {
    if (mediaType == null ||
        genre == null ||
        releaseYear == null ||
        country == null ||
        sortedBy == null) {
      return false;
    }
    return true;
  }

  @override
  List<Object?> get props => [
        mediaType,
        genre,
        releaseYear,
        country,
        sortedBy,
      ];
}
