import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:provider/provider.dart';

class SettingsBottomSheet extends StatefulWidget{

  @override
  _SettingsBottomSheet createState() => _SettingsBottomSheet();
}

class _SettingsBottomSheet extends State<SettingsBottomSheet> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffe8e8e8),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 40, left:20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New habit',
                    style: TextStyle(
                      // color: AppColors.Graphite,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Habit'
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final newHabit = Habit(
                              title: inputController.text,
                              createdTime: DateTime.now(),
                              dayList: []
                          );
                          await Provider.of<HabitProvider>(context, listen: false).add(newHabit);
                          Navigator.pop(context);
                        },
                        child: Text('Create'),
                        style: ElevatedButton.styleFrom(
                          // primary: AppColors.MintGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            minimumSize: Size(221, 55),
                            textStyle: TextStyle(fontSize: 18)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}