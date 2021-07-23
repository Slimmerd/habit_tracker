import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings',style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
          ),
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5),
            child: SizedBox(height: 0),
          ),
        ),
        backgroundColor: AppColors.BackgroundMainColor,
        body: ListView(
          children: [
            TextButton(
                onPressed: () =>
                    Provider.of<HabitProvider>(context, listen: false)
                        .deleteAll(),
                child: Text('Delete all habits')),
            TextButton(
                onPressed: () =>
                    Provider.of<TodoProvider>(context, listen: false)
                        .deleteAllTodoCategories(),
                child: Text('Delete all todos')),
          ],
        ));
  }
}
