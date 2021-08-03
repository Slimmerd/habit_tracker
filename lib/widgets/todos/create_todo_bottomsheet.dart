import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateTodoBottomSheet extends StatefulWidget {
  final TodoCategory todoCategory;

  CreateTodoBottomSheet({Key? key, required this.todoCategory})
      : super(key: key);

  @override
  _CreateTodoBottomSheetState createState() => _CreateTodoBottomSheetState();
}

class _CreateTodoBottomSheetState extends State<CreateTodoBottomSheet> {
  late String _name;
  late String _notes;
  DateTime? _due;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
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
                padding: EdgeInsets.only(top: 40, left: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New todo',
                      style: TextStyle(
                          color: AppColors.MainText,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.GrayLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextFormField(
                  style: TextStyle(color: AppColors.MainText),
                  decoration: InputDecoration(
                      hintText: 'Name',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(color: AppColors.GrayText)),
                  onSaved: (String? value) {
                    _name = value!;
                  },
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.GrayLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  style: TextStyle(color: AppColors.MainText),
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Notes',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(color: AppColors.GrayText)),
                  onSaved: (String? value) {
                    _notes = value!;
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  DatePicker.showDateTimePicker(context,
                      minTime: DateTime(2010),
                      maxTime: DateTime(2150),
                      currentTime: DateTime.now(),
                      onConfirm: (DateTime dueTime) {
                    setState(() => _due = dueTime);
                  });
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.GrayLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      _due != null
                          ? DateFormat('d MMMM HH:mm').format(_due!)
                          : 'Set due',
                      style: TextStyle(color: AppColors.GrayText),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        _formKey.currentState!.save();

                        final newCategoryTodo = Todo(
                            name: _name,
                            notes: _notes,
                            createdTime: DateTime.now(),
                            due: _due,
                            categoryID: widget.todoCategory.id!);

                        await Provider.of<TodoProvider>(context, listen: false)
                            .addTodo(newCategoryTodo, widget.todoCategory);

                        Navigator.pop(context);
                      },
                      child: Text('Create'),
                      style: ElevatedButton.styleFrom(
                          primary: Color(
                              Provider.of<TodoProvider>(context, listen: false)
                                  .todoCategories[Provider.of<TodoProvider>(
                                          context,
                                          listen: false)
                                      .todoCategories
                                      .indexWhere((element) =>
                                          element.id == widget.todoCategory.id)]
                                  .color),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                          minimumSize: Size(115, 45),
                          textStyle: TextStyle(fontSize: 18)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
