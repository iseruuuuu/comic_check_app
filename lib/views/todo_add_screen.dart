import 'package:comic_check_app/viewModels/todo_view_model.dart';
import 'package:comic_check_app/views/children/picker_item.dart';
import 'package:comic_check_app/views/children/text_field_item.dart';
import 'package:comic_check_app/views/children/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoAddScreen extends HookWidget {
  const TodoAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);
    final comicState = useProvider(todoViewModelProvider);
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30.w),
            const TitleText(title: 'コミック名'),
            TextFieldItem(
              onChanged: (word) {
                todoViewModel.onChangeWord(word);
              },
              hintText: '漫画名',
              maxLength: 20,
            ),
            SizedBox(height: 20.w),
            const TitleText(title: '出版社'),
            PickerItem(
              title: comicState.publisher,
              fontSize: 20.w,
              onTap: () async {
                await todoViewModel.openPublisher(context);
              },
            ),
            SizedBox(height: 30.w),
            const TitleText(title: '漫画の巻数'),
            PickerItem(
              title: '${comicState.count}' + '巻',
              fontSize: 30.w,
              onTap: () async {
                await todoViewModel.openComicCount(context);
              },
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 60.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (comicState.comicName != '' &&
                      comicState.publisher != '' &&
                      comicState.count != 0) {
                    await todoViewModel.addTodo(
                      comicState.comicName,
                      comicState.publisher,
                      comicState.count,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  '追加',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
