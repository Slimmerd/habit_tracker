import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_model.dart';

class TodoDismissible extends StatelessWidget {
  final Todo todo;
  final Function deleteFunction;
  final Widget child;

  TodoDismissible(
      {Key? key,
      required this.todo,
      required this.child, required this.deleteFunction,
     });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) => deleteFunction(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: AppColors.MainText,
              size: 32,
            ),
            Text(
              'Delete',
              style: TextStyle(color: AppColors.MainText, fontSize: 16),
            )
          ],
        ),
      ),
      child: child,
    );
  }
}
