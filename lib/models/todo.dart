import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    int? id,
    @Default('') String title,
    @Default('') String publisher,
    @Default(0) int count,
    //@Default([]) List<String> count,
    // @JsonKey(name: 'is_done') @Default(0) int isDone,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}