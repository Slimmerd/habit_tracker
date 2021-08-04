import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:provider/provider.dart';

class CreateHabitBottomSheet extends StatefulWidget {
  @override
  _CreateHabitBottomSheetState createState() => _CreateHabitBottomSheetState();
}

class _CreateHabitBottomSheetState extends State<CreateHabitBottomSheet> {
  late String _title;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.BackgroundMainColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        autofocus: true,
                        style:
                            TextStyle(fontSize: 24, color: AppColors.MainText),
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: 'New habit name',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.GrayText)),
                        onSaved: (String? value) {
                          _title = value!;
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        _formKey.currentState!.save();

                        final newHabit = Habit(
                            title: _title,
                            createdTime: DateTime.now(),
                            dayList: []);

                        await Provider.of<HabitProvider>(context, listen: false)
                            .add(newHabit);
                        Navigator.pop(context);
                      },
                      child: Text('Create'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                          minimumSize: Size(115, 45),
                          textStyle: TextStyle(fontSize: 18)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
