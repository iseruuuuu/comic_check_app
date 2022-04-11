import 'package:comic_check_app/models/todo.dart';
import 'package:comic_check_app/viewModels/todo_view_model.dart';
import 'package:comic_check_app/views/todo_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/all.dart';

class TodoDetailScreen extends HookWidget {
  const TodoDetailScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);
    final todoState = useProvider(todoViewModelProvider);
    useEffect(
      () {
        todoViewModel.getComic(todo.title);
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: const Text(
          '漫画詳細',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoEditScreen(
                    todo: todo,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              height: 80.w,
              color: Colors.grey.shade200,
              child: Center(
                child: Text(
                  todo.title + '/' + todo.publisher,
                  style: TextStyle(
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoViewModel.state.comics.length,
                itemBuilder: (BuildContext context, int index) {
                  var comic = todoViewModel.findByIndex(todo.count);
                  var selectedComic = todoViewModel.findByIndex(index + 1);
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.grey.shade100,
                      title: Text(
                        //'${index + 1} 巻',
                        '${index} 巻',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.w,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Switch(
                        value: selectedComic.done,
                        onChanged: (done) {
                          todoViewModel.update(
                            index: index,
                            comic: selectedComic,
                            done: done,
                            todo: todo,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
