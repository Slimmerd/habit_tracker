import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'habit_date.dart';
import 'habit_dismissible.dart';

class HabitItem extends StatefulWidget {
  final Habit habit;

  const HabitItem({Key? key, required this.habit}) : super(key: key);

  @override
  _HabitItemState createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  @override
  Widget build(BuildContext context) {
    return HabitDismissible(
      habit: widget.habit,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: widget.habit,
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.GrayLight,
              borderRadius: BorderRadius.circular(14)),
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.habit.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _checklist(widget.habit),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _checklist(Habit habit) {
    final List<HabitDate> dateList = [];
    final DateTime currentDate = new DateTime.now();

    for (var i = 4; i >= 0; i--) {
      DateTime date = currentDate.subtract(Duration(days: i));
      String dateString = date.toString().substring(0, 10);

      dateList.add(
        HabitDate(
          date: date,
          isChecked: habit.dayList!.indexOf(dateString) != -1,
          onChange: () => {
            Feedback.forTap(context),
            Provider.of<HabitProvider>(context, listen: false)
                .dayCompleted(habit, date)
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dateList,
    );
  }
}
