import 'package:freezed_annotation/freezed_annotation.dart';

part 'datas.freezed.dart';
part 'datas.g.dart';

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
