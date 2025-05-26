class BaseResponse<T> {
  final int? id;
  final bool success;
  final String message;
  final T? data;
  final dynamic errors;

  BaseResponse({
    required this.id,
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseResponse<T>(
      id: json['id'] ?? 0,
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      errors: json['errors'],
    );
  }
}
