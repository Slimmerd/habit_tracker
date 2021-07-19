import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';

// ignore: must_be_immutable
class CalendarDate extends StatefulWidget {
  CalendarDate({
    Key? key,
    required this.date,
    this.isActive = false,
    this.isSecondary = false,
    required this.onPressed,
    this.isDisabled = false,
  }): super(key: key);

  final DateTime date;
  late bool isActive;
  final bool isSecondary;
  final bool isDisabled;
  final Function(DateTime) onPressed;

  @override
  _CalendarDateState createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {
  final BoxDecoration activeStyle = BoxDecoration(
    color: AppColors.SelectedColor,
    shape: BoxShape.circle,
  );

  final BoxDecoration inActiveStyle = BoxDecoration(
    color: AppColors.NotSelectedColor,
    shape: BoxShape.circle,
  );

  @override
  Widget build(BuildContext context) {
    DateTime current = DateTime.now();

    BoxDecoration decoration = (widget.isActive ? activeStyle : inActiveStyle);

    if (current.year == widget.date.year &&
        current.month == widget.date.month &&
        current.day == widget.date.day) {
      decoration = decoration.copyWith(
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      );
    }

    return GestureDetector(
      onTap: () => {
        if (!widget.isDisabled) {
          setState(() => widget.isActive = !widget.isActive),
          widget.onPressed(widget.date),
        }
      },
      child: Opacity(
        opacity: (widget.isSecondary || widget.isDisabled) ? 0.5 : 1,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: decoration,
            padding: EdgeInsets.all(10),
            child: Text(
              widget.date.day.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(fontSize: 13, color: widget.isActive ? Colors.white : AppColors.GrayText),
            ),
          ),
        ),
      ),
    );
  }
}