import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/constants/dates.dart';
import 'package:habit_tracker/models/habit_model.dart';

import 'calendar_date.dart';
import 'calendar_header.dart';

class CalendarCard extends StatefulWidget {
  final Habit habit;
  final Function(DateTime) onToggleDate;

  CalendarCard({required this.habit, required this.onToggleDate});

  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  late DateTime date;

  _CalendarCardState() : this.date = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.GrayLight, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarHeader(
            AppDates.monthFullName[date.month - 1] + " " + date.year.toString(),
            onPrev: () {
              setState(() {
                date = new DateTime(date.year, date.month - 1, 1);
              });
            },
            onNext: () {
              setState(() {
                date = new DateTime(date.year, date.month + 1, 1);
              });
            },
          ),
          SizedBox(height: 10),
          Column(
            children: [
              _weekDaysRow(),
              _dateGrid(),
            ],
          ),
        ],
      ),
    );
  }


  Widget _weekDaysRow() {
    final List<Widget> dayList = [];

    for(var _day in AppDates.dayName){
          dayList.add(
              Text(
                _day,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppColors.GrayText),
              )
          );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dayList,
    );
  }

  Widget _dateGrid() {
    DateTime now = DateTime.now();
    now = DateTime.utc(now.year, now.month, now.day);
    // Get first date of calendar
    DateTime firstDate = DateTime.utc(date.year, date.month, 1);
    int firstWeekInCalendar = DateTime.monday - firstDate.weekday;
    firstDate = firstDate.add(Duration(days: firstWeekInCalendar));

    // Get last date of calendar
    DateTime lastDate = DateTime.utc(date.year, date.month + 1, 0);
    int lastWeekInCalendar = DateTime.sunday - lastDate.weekday;
    lastDate = lastDate.add(Duration(days: lastWeekInCalendar));

    // Generate widget
    List<Row> columnLists = [];
    DateTime current = firstDate;
    int row = 0;
    int column = -1;
    while (current.compareTo(lastDate) <= 0) {
      if (row % 7 == 0) {
        // Create row
        columnLists.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ));
        column++;
      }

      // Add dateItem Widget
      var dateWidget = CalendarDate(
        date: current,
        isSecondary: date.month != current.month,
        isActive: widget.habit.dayList!
                .indexOf(current.toString().substring(0, 10)) !=
            -1,
        onPressed: (dateClick) {
          if (date.month != dateClick.month) {
            setState(() {
              date = new DateTime(dateClick.year, dateClick.month, 1);
            });
          } else {
            widget.onToggleDate(dateClick);
          }
        },
        isDisabled: now.compareTo(current) < 0,
      );
      columnLists[column].children.add(dateWidget);

      // Increase current
      current = current.add(Duration(days: 1));
      row++;
    }

    return Column(
      children: columnLists,
    );
  }
}
