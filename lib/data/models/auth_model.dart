import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

/// OAuth token response
@freezed
class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required String accessToken,
    String? tokenType,
    int? expiresIn,
    String? refreshToken,
    String? scope,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}

/// OAuth token request
@freezed
class TokenRequest with _$TokenRequest {
  const factory TokenRequest({
    required String grantType,
    String? clientId,
    String? clientSecret,
    String? code,
    String? redirectUri,
    String? refreshToken,
  }) = _TokenRequest;

  factory TokenRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestFromJson(json);
}

/// Stored authentication data
@freezed
class AuthData with _$AuthData {
  const factory AuthData({
    required String accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}
