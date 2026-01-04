import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_model.freezed.dart';
part 'common_model.g.dart';

/// Pagination info used across different API responses
@freezed
class PageInfo with _$PageInfo {
  const factory PageInfo({
    String? page,
  }) = _PageInfo;

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);
}
