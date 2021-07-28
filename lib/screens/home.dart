import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:habit_tracker/widgets/create_habit_bottomsheet.dart';
import 'package:habit_tracker/widgets/habits/habit_card/habit_item.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{

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
              color: Color(0xff6f1bff),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff6f1bff),
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
