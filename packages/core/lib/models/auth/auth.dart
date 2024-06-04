import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable(explicitToJson: true)
class Auth {

  Auth(
      {required this.token,
      required this.username,
      required this.password});

  @JsonKey(name: "token", defaultValue: "")
  String token;

  @JsonKey(name: "username", defaultValue: "")
  String username;

  @JsonKey(name: "password", defaultValue: "")
  String password;


  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  
  Map<String, dynamic> toJson() => _$AuthToJson(this);
  
  factory Auth.emptyInstance() => Auth(token: "", username: "", password: "");
}


