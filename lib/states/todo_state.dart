import 'package:comic_check_app/models/comic.dart';
import 'package:comic_check_app/models/todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default([]) List<Todo> todos,
    //漫画の登録の際に使用(出版社)
    @Default('出版社を選択') String publisher,
    //漫画の登録の際に使用(何巻まであるのか)
    @Default(0) int count,
    //巻数の管理に使用
    @Default([]) List<Comic> comics,
    //編集の際に使用
    @Default('') String comicName,
  }) = _TodoState;
}
