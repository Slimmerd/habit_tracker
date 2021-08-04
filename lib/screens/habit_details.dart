import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:habit_tracker/widgets/habits/calendar_card/calendar_card.dart';
import 'package:habit_tracker/widgets/habits/stats_card/stats_card.dart';
import 'package:habit_tracker/widgets/habits/settings_habit_bottomsheet.dart';
import 'package:provider/provider.dart';

class HabitDetailsScreen extends StatefulWidget {
  @override
  _HabitDetailsScreenState createState() => _HabitDetailsScreenState();
}

class _HabitDetailsScreenState extends State<HabitDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Habit habit = ModalRoute.of(context)!.settings.arguments as Habit;

    return Consumer<HabitProvider>(
      builder: (BuildContext context, value, Widget? child) {
        Habit _habit = value.habits[
            value.habits.indexWhere((element) => element.id == habit.id)];

        return Scaffold(
          backgroundColor: AppColors.BackgroundMainColor,
          appBar: AppBar(
            elevation: 0,
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            title: Text(
              _habit.title,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: InkWell(
                  customBorder: CircleBorder(),
                  splashColor: Colors.transparent,
                  onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SettingsHabitBottomSheet(habit: _habit))),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.settings,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.only(bottom: 20),
            children: <Widget>[
              CalendarCard(
                habit: habit,
                onToggleDate: (date) {
                  Feedback.forTap(context);
                  Provider.of<HabitProvider>(context, listen: false)
                      .dayCompleted(habit, date);
                },
              ),
              MonthStatsChart(habit),
            ],
          ),
        );
      },
    );
  }
}
