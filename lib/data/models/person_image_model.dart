class ImageDetailModel {
  final double aspectRatio;
  final int height;
  final String? iso6391;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  const ImageDetailModel({
    required this.aspectRatio,
    required this.height,
    this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory ImageDetailModel.fromJson(Map<String, dynamic> json) {
    return ImageDetailModel(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble() ?? 0.0,
      height: json['height'] ?? 0,
      iso6391: json['iso_639_1'],
      filePath: json['file_path'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      width: json['width'] ?? 0,
    );
  }

  static List<ImageDetailModel> fetchData(Map<String, dynamic> json) {
    List data = json['profiles'];
    List<ImageDetailModel> result = [];
    data.forEach((value) {
      result.add(ImageDetailModel.fromJson(value));
    });
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      'aspect_ratio': aspectRatio,
      'height': height,
      'iso_639_1': iso6391,
      'file_path': filePath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'width': width,
    };
  }
}
