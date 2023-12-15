import 'dart:convert';

class ErrorMessage {
  final String message;
  final bool status;
  ErrorMessage({
    required this.message,
    required this.status,
  });

  factory ErrorMessage.fromMap(Map<String, dynamic> map) {
    return ErrorMessage(
      message: map['message'],
      status: map['status'],
    );
  }

  factory ErrorMessage.fromJson(String source) =>
      ErrorMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
