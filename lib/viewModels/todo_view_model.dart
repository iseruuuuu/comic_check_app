import 'dart:convert';
import 'package:comic_check_app/databases/todo_database.dart';
import 'package:comic_check_app/models/comic.dart';
import 'package:comic_check_app/models/todo.dart';
import 'package:comic_check_app/preference/preference.dart';
import 'package:comic_check_app/repositories/todo_repository.dart';
import 'package:comic_check_app/states/todo_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final todoViewModelProvider = StateNotifierProvider(
  (ref) => TodoViewModelProvider(
    ref.read,
    TodoRepository(TodoDatabase()),
    Preference(),
  ),
);

class TodoViewModelProvider extends StateNotifier<TodoState> {
  TodoViewModelProvider(this._reader, this._todoRepository, this.preference)
      : super(const TodoState()) {
    getTodos();
  }

  final Reader _reader;
  final TodoRepository _todoRepository;
  final Preference preference;

  List<Comic> list = [];
  String comicTitle = '';

  void getComic(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var loadList = prefs.getStringList(key) ?? [];
    var comic = loadList.map((a) => Comic.fromJson(json.decode(a))).toList();
    list = comic;
    if (comic.isEmpty) {
      state = state.copyWith(
        comics: comic,
      );
    } else {
      state = state.copyWith(
        comics: comic,
      );
    }
  }

  Comic findByIndex(int index) {
    if (state.comics.isEmpty) {
      return list[index];
    } else {
      return state.comics[index - 1];
    }
  }

  void update(
      {required int index,
      required Comic comic,
      required bool done,
      required Todo todo,}) async {
    list[index].done = done;
    state = state.copyWith(
      comics: list,
    );
    save(todo.title);
  }

  void save(String key) async {
    // TodoList形式 → Map形式 → JSON形式 → StringList形式
    var saveList = list.map((e) => json.encode(e.toJson())).toList();
    preference.setListString(key, saveList);
  }

  Future<void> addTodo(String title, String publisher, int count) async {
    list = [];
    final todo = await _todoRepository.addTodo(
      Todo(
        title: title,
        publisher: publisher,
        count: count,
      ),
    );
    state = state.copyWith(
      todos: [todo, ...state.todos],
    );
    addComic(count - 1, todo.title);
    save(title);
  }

  void addComic(int count, String key) {
    for (var id = 0; id <= count; id++) {
      var newComic = Comic(id, '$id', false);
      list.add(newComic);
    }
    state = state.copyWith(
      comics: list,
    );
    comicTitle = key;
  }

  Future<void> getTodos() async {
    final todos = await _todoRepository.getTodos();
    state = state.copyWith(
      todos: todos,
    );
  }

  Future<void> deleteTodo(int todoId) async {
    await _todoRepository.deleteTodo(todoId);
    final todos = state.todos.where((todo) => todo.id != todoId).toList();
    state = state.copyWith(
      todos: todos,
    );
  }

  Future<void> onSelectedItemChanged(int index, String publisher) async {
    state = state.copyWith(
      publisher: publisher,
    );
  }

  Future<void> onChanged(bool onChanged) async {}

  Future<void> onChangeWord(String comicName) async {
    state = state.copyWith(
      comicName: comicName,
    );
  }

  Future<void> openComicCount(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 40,
              children: List<Widget>.generate(1000, (index) => Text('$index')),
              onSelectedItemChanged: (index) {
                state = state.copyWith(
                  count: index,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
