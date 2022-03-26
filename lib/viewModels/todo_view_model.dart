import 'package:comic_check_app/databases/todo_database.dart';
import 'package:comic_check_app/models/todo.dart';
import 'package:comic_check_app/repositories/todo_repository.dart';
import 'package:comic_check_app/states/todo_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final todoViewModelProvider = StateNotifierProvider(
  (ref) => TodoViewModelProvider(
    ref.read,
    TodoRepository(TodoDatabase()),
  ),
);

class TodoViewModelProvider extends StateNotifier<TodoState> {
  TodoViewModelProvider(this._reader, this._todoRepository)
      : super(const TodoState()) {
    getTodos();
  }

  final Reader _reader;
  final TodoRepository _todoRepository;

  Future<void> addTodo(String title, String publisher, int count) async {
    final todo = await _todoRepository.addTodo(
      Todo(
        title: title, publisher: publisher, count: count,
        //isDone: 0,
      ),
    );
    state = state.copyWith(
      todos: [todo, ...state.todos],
    );
  }

  Future<void> getTodos() async {
    final todos = await _todoRepository.getTodos();
    state = state.copyWith(
      todos: todos,
    );
  }

  // Future<void> changeStatus(Todo todo, int value) async {
  //   final newTodo = todo.copyWith(
  //     isDone: value,
  //   );
  //   await _todoRepository.updateTodo(newTodo);
  //   final todos = state.todos
  //       .map((todo) => todo.id == newTodo.id ? newTodo : todo)
  //       .toList();
  //   state = state.copyWith(
  //     todos: todos,
  //   );
  // }

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
                print(index);
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
