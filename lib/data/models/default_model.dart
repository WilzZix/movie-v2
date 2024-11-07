class DefaultModel {
  DefaultModel({
    bool? success,
    num? statusCode,
    String? statusMessage,
  }) {
    _success = success!;
    _statusCode = statusCode!;
    _statusMessage = statusMessage!;
  }

  DefaultModel.fromJson(dynamic json) {
    _success = json['success'];
    _statusCode = json['status_code'];
    _statusMessage = json['status_message'];
  }

  bool? _success;
  num? _statusCode;
  String? _statusMessage;

  DefaultModel copyWith({
    bool? success,
    num? statusCode,
    String? statusMessage,
  }) =>
      DefaultModel(
        success: success ?? _success,
        statusCode: statusCode ?? _statusCode,
        statusMessage: statusMessage ?? _statusMessage,
      );

  bool? get success => _success;

  num? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['status_code'] = _statusCode;
    map['status_message'] = _statusMessage;
    return map;
  }
}
