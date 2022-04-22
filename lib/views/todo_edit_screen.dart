import 'package:comic_check_app/models/todo.dart';
import 'package:comic_check_app/viewModels/todo_view_model.dart';
import 'package:comic_check_app/views/children/edit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'children/back_icon.dart';
import 'children/picker_item.dart';
import 'children/text_field_item.dart';
import 'children/title_text.dart';

class TodoEditScreen extends HookWidget {
  const TodoEditScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);
    final comicState = useProvider(todoViewModelProvider);
    useEffect(
      () {
        WidgetsBinding.instance?.addPostFrameCallback(
          (_) {
            todoViewModel.initState(
              comicName: todo.title,
              publisher: todo.publisher,
              count: todo.count,
            );
          },
        );
      },
      const [],
    );
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: const BackIcon(
          icon: Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30.w),
            const TitleText(title: 'コミック名'),
            TextFieldItem(
              onChanged: (word) => todoViewModel.onChangeWord(word),
              comicName: todo.title,
              hintText: '漫画名',
              maxLength: 20,
            ),
            SizedBox(height: 20.w),
            const TitleText(title: '出版社'),
            PickerItem(
              title: comicState.publisher,
              fontSize: 20.w,
              onTap: () async => await todoViewModel.openPublisher(context),
            ),
            SizedBox(height: 30.w),
            const TitleText(title: '漫画の巻数'),
            PickerItem(
              title: '${comicState.count}' '巻',
              fontSize: 30.w,
              onTap: () async => await todoViewModel.openComicCount(context),
            ),
            const Spacer(),
            EditButton(
              onPressed: () async {
                if (comicState.comicName != '' &&
                    comicState.publisher != '' &&
                    comicState.count != 0) {
                  await todoViewModel.updateComic(todo.id!, todo);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
