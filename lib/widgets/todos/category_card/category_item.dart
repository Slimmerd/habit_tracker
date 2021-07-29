import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/screens/todo_details.dart';

class TodoCategoryItem extends StatefulWidget{
  final TodoCategory todoCategory;

  const TodoCategoryItem({Key? key, required this.todoCategory}): super(key: key);

  @override
  _TodoCategoryItemState createState() => _TodoCategoryItemState();
}

class _TodoCategoryItemState extends State<TodoCategoryItem> {
  double percent = 0;
  int leftTasks = 0;
  int allTasks = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(70),
                offset: Offset(3.0, 10.0),
                blurRadius: 15.0)
          ]),
      height: 300.0,
      width: 260,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => TodoDetailScreen(todoCategory: widget.todoCategory,),
                transitionDuration: Duration(milliseconds: 1000), reverseTransitionDuration: Duration(milliseconds: 1000)
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Hero(
              tag: "_background",
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.GrayLight,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Hero(
                              tag: "_backIcon",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  height: 0,
                                  width: 0,
                                  child:
                                  Icon(Icons.arrow_back, color: Colors.transparent),
                                ),
                              ),
                            ),
                            Hero(
                              tag: "_icon",
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.GrayText,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(IconData(widget.todoCategory.icon, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage),
                                      color: Color(widget.todoCategory.color)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Hero(
                          tag: "_more_vert",
                          child: Material(
                            color: Colors.transparent,
                            type: MaterialType.transparency,
                            child: PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text("Edit Color"),
                                  value:
                                  'TodoCardSettings.edit_color',
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
                                    // setState(() {
                                    //   todos.remove(todoObject);
                                    // });
                                    break;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Hero(
                    tag: "_number_of_tasks",
                    child: Material(
                        color: Colors.transparent,
                        child: Text(

                                '${widget.todoCategory.todoList!.where((element) => element.isCompleted == 0).toList().length} Tasks',
                          style: TextStyle(color: AppColors.GrayText),
                          softWrap: false,
                        )),
                  ),
                  Spacer(),
                  Hero(
                    tag: "_title",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.todoCategory.name,
                        style: TextStyle(
                            color: AppColors.MainText,
                            fontSize: 30.0),
                        softWrap: false,
                      ),
                    ),
                  ),
                  Spacer(),
                  Hero(tag: 'just_a_test', child: SizedBox(height: 1, width: 1,)),
                  Hero(
                    tag: "_progress_bar",
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: LinearProgressIndicator(
                              value: percent,
                              backgroundColor:
                              Colors.grey.withAlpha(50),
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                                  Color(widget.todoCategory.color)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              (percent * 100).round().toString() + "%",
                              style: TextStyle(
                                  color: AppColors.MainText),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}