class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }

  static List<GenreModel> fetchData(Map<String, dynamic> json) {
    List data = json['genres'];
    List<GenreModel> result = [];
    for (var value in data) {
      result.add(GenreModel.fromJson(value));
    }
    return result;
  }
}
