

import 'package:comic_check_app/databases/todo_database.dart';
import 'package:comic_check_app/models/todo.dart';

class TodoRepository {
  final _db = TodoDatabase();

  final TodoDatabase _todoDatabase;

  TodoRepository(this._todoDatabase);

  Future<List<Todo>> getTodos() async {
    return _todoDatabase.getTodos();
  }

  Future<Todo> addTodo(Todo todo) async {
    return _todoDatabase.insert(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    return _todoDatabase.update(todo);
  }

  Future<void> deleteTodo(int id) async {
    return _todoDatabase.delete(id);
  }
}
