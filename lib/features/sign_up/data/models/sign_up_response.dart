import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';

@JsonSerializable()
class SignupResponse {
  final int? id;
  final String? username;
  final String? email;
  final String? password;

  SignupResponse({
    this.id,
    this.username,
    this.email,
    this.password,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
