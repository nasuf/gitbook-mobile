import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model representing a GitBook user
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    String? displayName,
    String? email,
    String? photoUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Current authenticated user response
@freezed
class CurrentUserResponse with _$CurrentUserResponse {
  const factory CurrentUserResponse({
    required UserModel user,
  }) = _CurrentUserResponse;

  factory CurrentUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserResponseFromJson(json);
}
