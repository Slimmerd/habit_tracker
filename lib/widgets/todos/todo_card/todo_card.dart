import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/widgets/todos/todo_card/todo_dismissible.dart';
import 'package:habit_tracker/widgets/todos/todo_card/todo_open_bottomsheet.dart';
import 'package:intl/intl.dart';
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
  late String dateTest;

  @override
  void initState() {
    super.initState();
    dateShow();
  }

  @override
  void didUpdateWidget(covariant TodoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    dateShow();
  }

  void dateShow() {
    DateTime currentDate =
        widget.todo.due != null ? widget.todo.due! : DateTime.now();
    DateTime _now = DateTime.now();
    DateTime today = DateTime(_now.year, _now.month, _now.day);
    String dateString;

    DateTime currentDateDay =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    if (currentDateDay.isBefore(today.subtract(Duration(days: 7)))) {
      dateString = DateFormat.yMMMMEEEEd().format(currentDate);
    } else if (currentDateDay.isBefore(today)) {
      dateString = '${currentDateDay.difference(today).inDays.abs()}d ago';
    } else if (currentDateDay.isAtSameMomentAs(today)) {
      dateString = "Today";
    } else if (currentDateDay.isAtSameMomentAs(today.add(Duration(days: 1)))) {
      dateString = "Tomorrow";
    } else if (currentDateDay.isAfter(today.add(Duration(days: 1))) &&
        currentDateDay.difference(today).inDays < 7) {
      dateString = DateFormat.E().format(currentDate);
    } else if (currentDateDay.isAfter(today.add(Duration(days: 7))) &&
        currentDateDay.difference(today).inDays < 14) {
      dateString = '${currentDateDay.difference(today).inDays}d left';
    } else {
      dateString = DateFormat('d/M').format(currentDate);
    }

    dateTest = dateString;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TodoOpenBottomSheet(
            todo: widget.todo,
            deleteFunction: () => {
              Provider.of<TodoProvider>(context, listen: false)
                  .deleteTodo(widget.todo, widget.todoCategory),
            },
            color: Color(Provider.of<TodoProvider>(context, listen: false)
                .todoCategories[
                    Provider.of<TodoProvider>(context, listen: false)
                        .todoCategories
                        .indexWhere(
                            (element) => element.id == widget.todoCategory.id)]
                .color),
          ),
        ),
      ),
      child: TodoDismissible(
        todo: widget.todo,
        deleteFunction: () => {
          Provider.of<TodoProvider>(context, listen: false)
              .deleteTodo(widget.todo, widget.todoCategory),
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.GrayLight),
          margin: EdgeInsets.symmetric(vertical: 10),
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
                    activeColor: Color(Provider.of<TodoProvider>(context,
                            listen: false)
                        .todoCategories[
                            Provider.of<TodoProvider>(context, listen: false)
                                .todoCategories
                                .indexWhere((element) =>
                                    element.id == widget.todoCategory.id)]
                        .color),
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
                child: Text(dateTest,
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
