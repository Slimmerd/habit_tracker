import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/widgets/todos/category_card/category_item.dart';
import 'package:habit_tracker/widgets/todos/create_category_bottomsheet.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatefulWidget {
  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
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
              child: CreateCategoryBottomSheet(),
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
        title: Text('Todos',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            )),
      ),
      backgroundColor: Color(0xff131b26),
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text('${DateFormat('d MMMM').format(DateTime.now())}',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Consumer<TodoProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Expanded(
                flex: 6,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.todoCategories.length,
                    itemBuilder: (context, id) => TodoCategoryItem(
                        todoCategory: value.todoCategories[id])),
              );
            },
          ),
        ]),
      ),
    );
  }
}
