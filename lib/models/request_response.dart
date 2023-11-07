class RequestResponse {
  late bool success;
  String? message;
  dynamic data;

  RequestResponse(this.success, {this.message});

  RequestResponse.fromJson(json) {
    data = json['data'];
    success = true;
    message = json['message'] ?? "Success";
  }

  toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
