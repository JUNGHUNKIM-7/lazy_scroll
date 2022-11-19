import 'package:freezed_annotation/freezed_annotation.dart';

part 'datamap.freezed.dart';
part 'datamap.g.dart';

@freezed
class DataMap with _$DataMap {
  factory DataMap({
    String? title,
    String? href,
    String? created,
  }) = _DataMap;

  factory DataMap.fromJson(Map<String, Object?> json) =>
      _$DataMapFromJson(json);
}
