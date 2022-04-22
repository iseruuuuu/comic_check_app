import 'package:comic_check_app/models/todo.dart';
import 'package:comic_check_app/viewModels/todo_view_model.dart';
import 'package:comic_check_app/views/children/back_icon.dart';
import 'package:comic_check_app/views/todo_edit_screen.dart';
import 'package:flutter/cupertino.dart';
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
    useEffect(
      () {
        todoViewModel.getComic(todo.key);
      },
    );
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.destructiveRed,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: const BackIcon(
          icon: Icons.arrow_back_ios_sharp,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              height: 80.w,
              color: CupertinoColors.destructiveRed,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 20.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      todo.publisher,
                      style: TextStyle(
                        fontSize: 20.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
                        '${index + 1} 巻',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.w,
                          color: Colors.black,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                      trailing: Transform.scale(
                        scale: 1.4.w,
                        child: Switch(
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.width / 5,
        child: FloatingActionButton(
          child: Icon(
            Icons.edit,
            size: 40.w,
          ),
          backgroundColor: Colors.redAccent,
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
        ),
      ),
    );
  }
}
