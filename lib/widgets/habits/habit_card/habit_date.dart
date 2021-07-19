import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/constants/dates.dart';

// ignore: must_be_immutable
class HabitDate extends StatefulWidget {
  HabitDate({ Key? key,
    required this.date,
    this.isChecked = false,
    required this.onChange})
      : super(key: key);

  final DateTime date;
  bool isChecked;
  final Function onChange;

  @override
  _HabitDateState createState() => _HabitDateState();
}

class _HabitDateState extends State<HabitDate> {
  @override
  Widget build(BuildContext context) {
    final int weekday = widget.date.weekday - 1;
    final BoxDecoration active = BoxDecoration(
      color: AppColors.SelectedColor,
      shape: BoxShape.circle,
    );
    final BoxDecoration inActive =
    BoxDecoration(color: AppColors.NotSelectedColor, shape: BoxShape.circle);

    return GestureDetector(
      onTap: () => {widget.onChange()},
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Text(
              AppDates.dayName[weekday],
              style: TextStyle(fontSize: 14, color: AppColors.GrayText),
            ),
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(top: 5),
              decoration: widget.isChecked ? active : inActive,
              child: Center(
                child: Text(
                  widget.date.day.toString(),
                  style: TextStyle(fontSize: 15, color: widget.isChecked ? Colors.white : AppColors.GrayText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}