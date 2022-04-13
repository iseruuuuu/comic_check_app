// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$_$_TodoFromJson(Map<String, dynamic> json) {
  return _$_Todo(
    id: json['id'] as int?,
    title: json['title'] as String? ?? '',
    publisher: json['publisher'] as String? ?? '',
    count: json['count'] as int? ?? 0,
    key: json['key'] as String? ?? '',
  );
}

Map<String, dynamic> _$_$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publisher': instance.publisher,
      'count': instance.count,
      'key': instance.key,
    };
