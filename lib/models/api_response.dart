import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class ApiResponse<T> {
  int code;
  String message;
  String path;
  T? data;
  DateTime? timestamp;

  ApiResponse({
    this.code = 0,
    this.message = '',
    this.path = '',
    this.data,
    this.timestamp,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson<T>(json, fromJsonT);
      
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  @override
  String toString() {
    return 'ApiResponse(code: $code, message: $message, path: $path, data: $data, timestamp: $timestamp)';
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse<T>(
      code: map['code'] ?? 0,
      message: map['message'] ?? '',
      path: map['path'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp'] as String) : null,
    );
  }

  factory ApiResponse.errorResponse(String source) => ApiResponse.fromMap(json.decode(source));
}
