import 'dart:convert';
import 'package:comic_check_app/databases/todo_database.dart';
import 'package:comic_check_app/models/comic.dart';
import 'package:comic_check_app/models/publisher.dart';
import 'package:comic_check_app/models/todo.dart';
import 'package:comic_check_app/preference/preference.dart';
import 'package:comic_check_app/repositories/todo_repository.dart';
import 'package:comic_check_app/states/todo_state.dart';
import 'package:comic_check_app/views/setting_screen.dart';
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

  //TODO DetailScreen
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

  void update({
    required int index,
    required Comic comic,
    required bool done,
    required Todo todo,
  }) async {
    list[index].done = done;
    state = state.copyWith(
      comics: list,
    );
    save(todo.key);
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
        key: title,
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
      publisher: '出版社を選択',
      count: 0,
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

  //TODO AddScreen
  Future<void> onChangeWord(String comicName) async {
    state = state.copyWith(
      comicName: comicName,
    );
  }

  Future<void> openPublisher(BuildContext context) async {
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
              children: publisher.map((publisher) => Text(publisher)).toList(),
              onSelectedItemChanged: (index) {
                state = state.copyWith(
                  publisher: publisher[index],
                );
              },
            ),
          ),
        );
      },
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
              children: List<Widget>.generate(100, (index) => Text('$index')),
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

//TODO EditScreen
  Future<void> changePublisher(String publisher) async {
    state = state.copyWith(
      publisher: publisher,
    );
  }

  String text({required int count}) {
    return '${state.count}';
  }

  // String publisher() {
  //   return state.publisher;
  // }

  Future<void> updateComic(int todoId, Todo todo) async {
    final newTodo = todo.copyWith(
      title: state.comicName,
      count: state.count,
      publisher: state.publisher,
      key: todo.key,
    );
    await _todoRepository.updateTodo(newTodo);
    if (list.length < state.count) {
      for (var id = 0; id < state.count; id++) {
        if (id >= list.length) {
          var newComic = Comic(id, '$id', false);
          list.add(newComic);
        }
      }
    } else {
      for (var id = list.length - 1; id > 0; id--) {
        if (id >= state.count) {
          list.removeLast();
        }
      }
    }
    save(todo.key);
    final updateTodo = state.todos
        .map((todo) => todo.id == newTodo.id ? newTodo : todo)
        .toList();
    state = state.copyWith(
      todos: updateTodo,
      comics: list,
    );
  }

  void onTapSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingScreen(),
      ),
    );
  }
}
