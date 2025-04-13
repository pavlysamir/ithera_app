class ErrorModel {
  final String? errorMessage;
  final List<String>? errors;

  ErrorModel({
    this.errorMessage,
    this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) {
      return ErrorModel(
        errorMessage: 'Something went wrong',
        errors: ['Something went wrong'],
      );
    }

    final errorMessage = jsonData['message'] ?? 'Unknown error';
    final dynamic errorsRaw = jsonData['errors'];

    List<String> errorsList = [];

    if (errorsRaw is List) {
      errorsList = errorsRaw.map((e) => e.toString()).toList();
    } else if (errorsRaw is String) {
      errorsList = [errorsRaw];
    }

    return ErrorModel(
      errorMessage: errorMessage,
      errors: errorsList,
    );
  }
}
