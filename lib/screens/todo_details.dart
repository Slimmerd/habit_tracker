import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/widgets/todos/create_todo_bottomsheet.dart';
import 'package:habit_tracker/widgets/todos/todo_card/todo_card.dart';
import 'package:provider/provider.dart';

class TodoDetailScreen extends StatefulWidget {
  final TodoCategory todoCategory;

  const TodoDetailScreen({Key? key, required this.todoCategory})
      : super(key: key);

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  int? completedTasks;
  double? percentage = 0;

  // @override
  // void initState() {
  //   completedTasks = widget.todoCategory.todoList?.where((element) => element.isCompleted == 1).toList().length;
  //   percentage = (completedTasks / widget.todoCategory.todoList!.length);
  //   // print(widget.todoCategory.toJson());
  //   // print(widget.todoCategory.todoList);
  //   // allTasks = widget.todoCategory.tod
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<TodoProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return  Stack(
          children: <Widget>[
            Hero(
              tag: "_background",
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.BackgroundMainColor,
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            Scaffold(
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
                      child:
                      CreateTodoBottomSheet(todoCategory: widget.todoCategory),
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
              backgroundColor: AppColors.BackgroundMainColor,
              appBar: AppBar(
                brightness: Brightness.dark,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: Hero(
                  tag: "_backIcon",
                  child: Material(
                    color: Colors.transparent,
                    type: MaterialType.transparency,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: AppColors.MainText,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                actions: <Widget>[
                  Hero(
                    tag: "_more_vert",
                    child: Material(
                      color: Colors.transparent,
                      type: MaterialType.transparency,
                      child: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: AppColors.MainText,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Edit Color"),
                            value: 'TodoCardSettings.edit_color',
                          ),
                          PopupMenuItem(
                            child: Text("Delete"),
                            value: 'TodoCardSettings.delete',
                          ),
                        ],
                        onSelected: (setting) {
                          switch (setting) {
                            case 'TodoCardSettings.edit_color':
                              print("edit color clicked");
                              break;
                            case 'TodoCardSettings.delete':
                              print("delete clicked");
                              break;
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Hero(
                          tag: "_icon",
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey.withAlpha(70),
                                  style: BorderStyle.solid,
                                  width: 1.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(IconData(widget.todoCategory.icon, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage),
                                color: Color(widget.todoCategory.color),),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Hero(
                          tag: "_number_of_tasks",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              '${widget.todoCategory.todoList!.length} Tasks',
                              style: TextStyle(color: AppColors.GrayText),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Hero(
                          tag: "_title",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              widget.todoCategory.name,
                              style: TextStyle(
                                  fontSize: 30.0, color: AppColors.MainText),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Hero(
                          tag: "_progress_bar",
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: percentage,
                                    backgroundColor: Colors.grey.withAlpha(50),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.SelectedColor),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    (percentage! * 100).round().toString() + "%",
                                    style: TextStyle(color: AppColors.MainText),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag: "just_a_test",
                        child: Material(
                          type: MaterialType.transparency,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            // itemBuilder: (BuildContext context, int index) {
                            //   DateTime currentDate = todoObject.tasks.keys.toList()[index];
                            //   DateTime _now = DateTime.now();
                            //   DateTime today = DateTime(_now.year, _now.month, _now.day);
                            //   String dateString;
                            //   if (currentDate.isBefore(today.subtract(Duration(days: 7)))) {
                            //     dateString = DateFormat.yMMMMEEEEd().format(currentDate);
                            //   } else if (currentDate.isBefore(today)) {
                            //     dateString = "Previous - " + DateFormat.E().format(currentDate);
                            //   } else if (currentDate.isAtSameMomentAs(today)) {
                            //     dateString = "Today";
                            //   } else if (currentDate.isAtSameMomentAs(today.add(Duration(days: 1)))) {
                            //     dateString = "Tomorrow";
                            //   } else {
                            //     dateString = DateFormat.E().format(currentDate);
                            //   }
                            //   List<Widget> tasks = [Text(dateString)];
                            //   var todoObject;
                            //   todoObject.tasks[currentDate].forEach((task) {
                            //     tasks.add(CustomCheckboxListTile(
                            //       activeColor: todoObject.color,
                            //       value: task.isCompleted(),
                            //       onChanged: (value) {
                            //         // setState(() {
                            //         //   task.setComplete(value);
                            //         // });
                            //       },
                            //       title: Text(task.task),
                            //       secondary: Icon(Icons.alarm),
                            //     ));
                            //   });
                            //   return Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: tasks,
                            //   );
                            // },
                            // itemCount: widget.todoObject.tasks.length,
                            // itemCount: 1,
                            itemCount: widget.todoCategory.todoList!.length,
                            itemBuilder: (BuildContext context, int id) {
                              return TodoCard(
                                  todo: widget.todoCategory.todoList![id],
                                  todoCategory: widget.todoCategory);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
