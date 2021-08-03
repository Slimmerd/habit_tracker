import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:provider/provider.dart';

class SettingsHabitBottomSheet extends StatefulWidget {
  final Habit habit;

  SettingsHabitBottomSheet({Key? key, required this.habit}) : super(key: key);

  @override
  _SettingsBottomSheet createState() => _SettingsBottomSheet();
}

class _SettingsBottomSheet extends State<SettingsHabitBottomSheet> {
  late String _title;

  @override
  void initState() {
    _title = widget.habit.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.BackgroundMainColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              padding:
                  EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      autofocus: true,
                      initialValue: _title,
                      style: TextStyle(fontSize: 24, color: AppColors.MainText),
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'New todo name',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(color: AppColors.GrayText)),
                      onChanged: (String value) async {
                        setState(() => _title = value);
                        final newHabit = Habit(
                            id: widget.habit.id,
                            title: _title,
                            createdTime: widget.habit.createdTime,
                            dayList: widget.habit.dayList);
                        await Provider.of<HabitProvider>(context, listen: false)
                            .update(newHabit);
                      },
                    ),
                  ),
                  Container(
                      child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _customElevatedButton(() async {
                          await Provider.of<HabitProvider>(context,
                                  listen: false)
                              .delete(widget.habit);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, 'Delete'),
                        _customElevatedButton(
                          () async {
                            await Provider.of<HabitProvider>(context,
                                    listen: false)
                                .resetProgress(widget.habit);
                            Navigator.pop(context);
                          },
                          'Reset',
                        )
                      ],
                    ),
                  ])),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget _customElevatedButton(void Function() onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          minimumSize: Size(115, 45),
          textStyle: TextStyle(fontSize: 18)),
    );
  }
}
