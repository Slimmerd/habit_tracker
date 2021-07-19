import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class CreateTodoBottomSheet extends StatefulWidget{
  final TodoCategory todoCategory;

  CreateTodoBottomSheet({Key? key, required this.todoCategory}): super(key: key);

  @override
  _CreateTodoBottomSheetState createState() => _CreateTodoBottomSheetState();
}

class _CreateTodoBottomSheetState extends State<CreateTodoBottomSheet> {

  late String _name;
  // late String _icon;
  // final int _color = AppColors.SelectedColor.value;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      color: Color(0xff707070),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffe8e8e8),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, left:20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New todo',
                      style: TextStyle(
                        // color: AppColors.Graphite,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: 'Icon'
              //     ),
              //     onSaved: (String? value) {
              //       _icon = value!;
              //     },
              //   ),
              // ),

              // TODO Color selector
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: 'Color'
              //     ),
              //     onSaved: (String? value) {
              //       _color = value!;
              //     },
              //   ),
              // ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name'
                  ),
                  onSaved: (String? value) {
                    _name = value!;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            _formKey.currentState!.save();

                            print(_name);
                            // print(_icon);
                            // print(_color);
                            final newCategoryTodo = Todo(
                                name: _name,
                                createdTime: DateTime.now(),
                                categoryID: widget.todoCategory.id!
                            );

                            await Provider.of<TodoProvider>(context, listen: false).addTodo(newCategoryTodo,widget.todoCategory);

                            // final newHabit = Habit(
                            //     title: inputController.text,
                            //     createdTime: DateTime.now(),
                            //     dayList: []
                            // );
                            // await Provider.of<HabitProvider>(context, listen: false).add(newHabit);
                            Navigator.pop(context);
                          },
                          child: Text('Create'),
                          style: ElevatedButton.styleFrom(
                            // primary: AppColors.MintGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                              minimumSize: Size(221, 55),
                              textStyle: TextStyle(fontSize: 18)),
                        ),
                      ],
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