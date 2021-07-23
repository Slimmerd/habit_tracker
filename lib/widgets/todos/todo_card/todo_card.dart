import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/widgets/todos/todo_card/todo_dismissible.dart';
import 'package:habit_tracker/widgets/todos/todo_card/todo_open_bottomsheet.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  final TodoCategory todoCategory;

  TodoCard({Key? key, required this.todo, required this.todoCategory})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child:
          TodoOpenBottomSheet(todo: widget.todo, deleteFunction: () => {
            Provider.of<TodoProvider>(context, listen: false)
                .deleteTodo(widget.todo, widget.todoCategory),
          },),
        ),
      ),
      child: TodoDismissible(
        todo: widget.todo,
        deleteFunction: () =>{
          Provider.of<TodoProvider>(context, listen: false)
              .deleteTodo(widget.todo, widget.todoCategory),
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.GrayLight),
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    side: BorderSide(color: AppColors.MainText, width: 1.5),
                    value: widget.todo.isCompleted == 0 ? false : true,
                    onChanged: (bool? value) {
                      Provider.of<TodoProvider>(context, listen: false)
                          .todoCompleted(widget.todo);
                    },
                  ),
                ),
              ),

              Flexible(
                flex: 5,
                child: Text(
                  widget.todo.name,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(color: AppColors.MainText, fontSize: 14.0),
                ),
              ),

              ///Constraints
              ///Show up to 14d left -> Date e.g 2/07
              ///Due date -> Today
              ///On Russian show 14 дн
              Flexible(
                flex: 2,
                child: Text('Today',
                    softWrap: false,
                    style: TextStyle(color: AppColors.MainText, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
