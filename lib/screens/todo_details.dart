import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/widgets/todos/create_todo_bottomsheet.dart';
import 'package:habit_tracker/widgets/todos/edit_category_bottomsheet.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<TodoProvider>(
      builder: (BuildContext context, value, Widget? child) {
        TodoCategory _todoCategory = value.todoCategories[value.todoCategories
            .indexWhere((element) => element.id == widget.todoCategory.id)];
        return Stack(
          children: <Widget>[
            Hero(
              tag: '_background_${widget.todoCategory.id}',
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.BackgroundMainColor,
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            Scaffold(
              floatingActionButton: Hero(
                tag: '_add_button_${widget.todoCategory.id}',
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
                        child: CreateTodoBottomSheet(
                            todoCategory: widget.todoCategory),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(_todoCategory.color),
                        boxShadow: [
                          BoxShadow(
                              color: Color(_todoCategory.color),
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
              backgroundColor: AppColors.BackgroundMainColor,
              appBar: AppBar(
                brightness: Brightness.dark,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: Hero(
                  tag: '_backIcon_${widget.todoCategory.id}',
                  child: Material(
                    color: Colors.transparent,
                    type: MaterialType.transparency,
                    child: IconButton(
                      splashRadius: 1,
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
                    tag: '_more_vert_${widget.todoCategory.id}',
                    child: Material(
                      color: Colors.transparent,
                      type: MaterialType.transparency,
                      child: IconButton(
                        splashRadius: 1,
                        icon: Icon(
                          Icons.more_vert,
                          color: AppColors.MainText,
                        ),
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: CategoryEditBottomSheet(
                              todoCategory: widget.todoCategory,
                              deleteFunction: () => {
                                Provider.of<TodoProvider>(context,
                                        listen: false)
                                    .deleteTodoCategory(widget.todoCategory),
                              },
                            ),
                          ),
                        ),
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
                          tag: '_icon_${widget.todoCategory.id}',
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey.withAlpha(70),
                                  style: BorderStyle.solid,
                                  width: 1.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                IconData(_todoCategory.icon,
                                    fontFamily: CupertinoIcons.iconFont,
                                    fontPackage:
                                        CupertinoIcons.iconFontPackage),
                                color: Color(_todoCategory.color),
                                size: 32,
                              ),
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
                          tag: '_number_of_tasks_${widget.todoCategory.id}',
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
                          tag: '_title_${widget.todoCategory.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              _todoCategory.name,
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
                          tag: '_progress_bar_${widget.todoCategory.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: widget
                                                .todoCategory.todoList!.length >
                                            0
                                        ? (widget.todoCategory.todoList!
                                                .where((element) =>
                                                    element.isCompleted == 1)
                                                .toList()
                                                .length /
                                            widget
                                                .todoCategory.todoList!.length)
                                        : 0,
                                    backgroundColor: Colors.grey.withAlpha(50),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(_todoCategory.color)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    ((widget.todoCategory.todoList!.length > 0
                                                    ? (widget.todoCategory
                                                            .todoList!
                                                            .where((element) =>
                                                                element
                                                                    .isCompleted ==
                                                                1)
                                                            .toList()
                                                            .length /
                                                        widget.todoCategory
                                                            .todoList!.length)
                                                    : 0) *
                                                100)
                                            .round()
                                            .toString() +
                                        "%",
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
                        tag: '_todos_list_${widget.todoCategory.id}',
                        child: Material(
                          type: MaterialType.transparency,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
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
