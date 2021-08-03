import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:habit_tracker/widgets/create_habit_bottomsheet.dart';
import 'package:habit_tracker/widgets/habits/habit_card/habit_item.dart';
import 'package:provider/provider.dart';

class HabitsScreen extends StatefulWidget {
  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: CreateHabitBottomSheet(),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.SelectedColor,
              boxShadow: [
                BoxShadow(
                    color: AppColors.SelectedColor,
                    offset: Offset(0, 3),
                    blurRadius: 5.0),
              ],
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        title: Text(
          'Habits',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: SizedBox(height: 0),
        ),
      ),
      backgroundColor: AppColors.BackgroundMainColor,
      body: Consumer<HabitProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: value.habits.length,
                    itemBuilder: (ctx, id) {
                      return HabitItem(habit: value.habits[id]);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  // Keep Alive
  bool get wantKeepAlive => true;
}
