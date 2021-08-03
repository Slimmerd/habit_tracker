import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TodoOpenBottomSheet extends StatefulWidget {
  final Color color;
  final Todo todo;
  final Function deleteFunction;

  TodoOpenBottomSheet(
      {Key? key, required this.todo, required this.deleteFunction, required this.color})
      : super(key: key);

  @override
  _TodoOpenBottomSheetState createState() => _TodoOpenBottomSheetState();
}

class _TodoOpenBottomSheetState extends State<TodoOpenBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? dueDate;

  @override
  void initState() {
    dueDate = widget.todo.due;
    super.initState();
  }

  void updateTodo([String? name, String? notes, DateTime? due]) {
    var _todo = new Todo(
      id: widget.todo.id,
      categoryID: widget.todo.categoryID,
      isCompleted: widget.todo.isCompleted,
      name: name != null ? name : widget.todo.name,
      notes: notes != null ? notes : widget.todo.notes,
      createdTime: widget.todo.createdTime,
      due: due != null ? due : widget.todo.due,
    );

    Provider.of<TodoProvider>(context, listen: false).updateTodo(_todo);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<TodoProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.BackgroundMainColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 40, left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    activeColor: widget.color,
                                    side: BorderSide(
                                        color: AppColors.MainText, width: 1.5),
                                    value: widget.todo.isCompleted == 0
                                        ? false
                                        : true,
                                    onChanged: (bool? value) {
                                      Provider.of<TodoProvider>(context,
                                              listen: false)
                                          .todoCompleted(widget.todo);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 24,
                                  child: TextFormField(
                                      initialValue: widget.todo.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.MainText),
                                      decoration: InputDecoration(
                                        hintText: 'Task name',
                                        hintStyle: TextStyle(
                                            color: AppColors.GrayText),
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      ),
                                      onChanged: (String value) =>
                                          updateTodo(value)),
                                ),
                              ),
                              Spacer(),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: () => {
                                    widget.deleteFunction(),
                                    Navigator.pop(context)
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.MainText,
                                    ),
                                  ),
                                ),
                              ),
                              // IconButton(onPressed: (){}, icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.GrayLight,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                              style: TextStyle(color: AppColors.MainText),
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              initialValue: widget.todo.notes,
                              decoration: InputDecoration(
                                  hintText: 'Notes',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle:
                                      TextStyle(color: AppColors.GrayText)),
                              onChanged: (String value) =>
                                  updateTodo(null, value)),
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDateTimePicker(context,
                                minTime: DateTime(2010),
                                maxTime: DateTime(2150),
                                currentTime: DateTime.now(),
                                onConfirm: (DateTime dueTime) {
                              updateTodo(null, null, dueTime);
                              setState(() => dueDate = dueTime);
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColors.GrayLight,
                                borderRadius: BorderRadius.circular(14),
                            ),
                              width: double.infinity,
                              child: Text(
                            dueDate != null
                                ? DateFormat('d MMMM HH:mm').format(dueDate!)
                                : 'Set due',
                            style: TextStyle(color: AppColors.MainText),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
