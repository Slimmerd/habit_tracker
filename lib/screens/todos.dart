import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        title: Text('Todos',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            )),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Material(
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
          ),
        ],
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
                Text('Today is ${DateFormat('d MMMM').format(DateTime.now())}',
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                    )),
                Text('You have 10 task due today',
                    style: TextStyle(
                      fontSize: 18,
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
                flex: 5,
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
