import 'package:comic_check_app/models/todo.dart';
import 'package:comic_check_app/viewModels/todo_view_model.dart';
import 'package:comic_check_app/views/children/no_list_screen.dart';
import 'package:comic_check_app/views/todo_add_screen.dart';
import 'package:comic_check_app/views/todo_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoListScreen extends HookWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.destructiveRed,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => todoViewModel.onTapSetting(context),
            iconSize: 35.w,
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _todoList(),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.width / 5,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 40.w,
          ),
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            Navigator.of(
              context,
              rootNavigator: true,
            ).push(
              MaterialPageRoute(
                builder: (context) {
                  return const TodoAddScreen();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _todoList() {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);
    final todoState = useProvider(todoViewModelProvider);
    if (todoState.todos.length != 0) {
      return ListView.builder(
        itemCount: todoState.todos.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = todoState.todos[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) async {
              await todoViewModel.deleteTodo(todo.id!);
            },
            child: _todoItem(todo, index, todoViewModel, context),
          );
        },
      );
    } else {
      return const NoListScreen();
    }
  }

  Widget _todoItem(
    Todo todo,
    int index,
    TodoViewModelProvider todoViewModel,
    BuildContext context,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
      ),
      child: ListTile(
        tileColor: Colors.grey.shade200,
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.w,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          todo.publisher,
          style: TextStyle(
            fontSize: 20.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 30.w,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoDetailScreen(
                todo: todo,
              ),
            ),
          );
        },
      ),
    );
  }
}
