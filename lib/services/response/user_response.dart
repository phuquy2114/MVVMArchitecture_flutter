import 'package:json_annotation/json_annotation.dart';
import 'package:mvvmarchitecture_flutter/model/user_model.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'data')
  List<User> data;

  UserResponse();

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
