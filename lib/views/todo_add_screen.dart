import 'package:comic_check_app/models/publisher.dart';
import 'package:comic_check_app/viewModels/todo_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoAddScreen extends HookWidget {
  const TodoAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);
    final titleController = TextEditingController();
    final comicState = useProvider(todoViewModelProvider);
    final comic = comicState.publisher;
    final count = comicState.count;
    final comicName = comicState.comicName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '漫画名',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.w,
            ),
          ),
          SizedBox(
            width: 300.w,
            child: TextField(
              // controller: titleController,
              style: TextStyle(fontSize: 20.w),
              autocorrect: false,
              onChanged: (comicName) {
                todoViewModel.onChangeWord(comicName);
              },
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '出版社',
                  style: TextStyle(
                    fontSize: 22.w,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: ' / ',
                  style: TextStyle(
                    fontSize: 25.w,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: comic,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 2,
            child: CupertinoPicker(
              backgroundColor: Colors.grey.shade200,
              looping: true,
              itemExtent: 30,
              scrollController: FixedExtentScrollController(initialItem: 0),
              onSelectedItemChanged: (index) =>
                  todoViewModel.onSelectedItemChanged(index, publisher[index]),
              children: publisher.map((publisher) => Text(publisher)).toList(),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '巻数',
                  style: TextStyle(
                    fontSize: 35.w,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: ' / ',
                  style: TextStyle(
                    fontSize: 35.w,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '$count巻',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 35.w,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await todoViewModel.openComicCount(context);
                    },
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 40.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                if (comicName != '' && comic != '' && count != 0) {
                  await todoViewModel.addTodo(comicName, comic, count);
                  Navigator.pop(context);
                }
              },
              child: Text(
                '追加',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
