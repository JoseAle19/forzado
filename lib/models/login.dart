class ApiResponse {
  final bool success;
  final String? message;
  final String? token;

  ApiResponse({required this.success, this.message, this.token});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("token")) {
      return ApiResponse(success: true, token: json["token"]);
    }
    return ApiResponse(success: false, message: json["message"]);
  }

  factory ApiResponse.fromJson2(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
