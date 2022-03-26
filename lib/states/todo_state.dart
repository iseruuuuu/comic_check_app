import 'package:comic_check_app/models/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default([]) List<Todo> todos,
    @Default('') String publisher,
    @Default(0) int count,
    @Default('') String comicName,
  }) = _TodoState;
}
