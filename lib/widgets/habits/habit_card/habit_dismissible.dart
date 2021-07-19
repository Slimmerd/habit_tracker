import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:provider/provider.dart';

import 'habit_alert.dart';

class HabitDismissible extends StatelessWidget {
  final Habit habit;
  final Widget child;

  HabitDismissible({Key? key, required this.habit, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(habit.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) =>
          Provider.of<HabitProvider>(context, listen: false).delete(habit),
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
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return HabitAlert();
          },
        );
      },
      child: child,
    );
  }
}
