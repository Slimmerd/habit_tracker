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
        height: MediaQuery.of(context).size.height * 0.40,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.BackgroundMainColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              padding: EdgeInsets.only(top: 40, left: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Habit settings',
                    style: TextStyle(
                        color: AppColors.MainText,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.SelectedColor)),
                  hintText: 'Habit',
                  hintStyle: TextStyle(color: AppColors.MainText),
                ),
                style: TextStyle(color: AppColors.MainText),
                onChanged: (String value) {
                  setState(() => _title = value);
                },
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customElevatedButton(
                        () async {
                          final newHabit = Habit(
                              id: widget.habit.id,
                              title: _title,
                              createdTime: widget.habit.createdTime,
                              dayList: widget.habit.dayList);
                          await Provider.of<HabitProvider>(context,
                                  listen: false)
                              .update(newHabit);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        'Save',
                      ),
                      _customElevatedButton(() async {
                        await Provider.of<HabitProvider>(context, listen: false)
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
          ]),
        ));
  }

  Widget _customElevatedButton(void Function() onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          textStyle: TextStyle(fontSize: 18)),
    );
  }
}
