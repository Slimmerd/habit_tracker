import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoOpenBottomSheet extends StatefulWidget {
  final Todo todo;

  TodoOpenBottomSheet({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoOpenBottomSheetState createState() => _TodoOpenBottomSheetState();
}

class _TodoOpenBottomSheetState extends State<TodoOpenBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
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
                padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                side: BorderSide(
                                    color: AppColors.GrayLight, width: 1.5),
                                value: widget.todo.isCompleted == 0 ? false : true,
                                onChanged: (bool? value) {
                                  Provider.of<TodoProvider>(context, listen: false)
                                      .todoCompleted(widget.todo);
                                },
                              ),
                            ),
                          ),
                          Text(
                            widget.todo.name,
                            style: TextStyle(
                                // color: AppColors.Graphite,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
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
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(widget.todo.notes != null
                          ? widget.todo.notes!
                          : 'Without further interruption'),
                    ),
                    Text(widget.todo.due != null
                        ? widget.todo.due.toString()
                        : '02 Jujne')
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

              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: 'Name'
              //     ),
              //     onSaved: (String? value) {
              //       _name = value!;
              //     },
              //   ),
              // ),

              // Container(
              //   padding: EdgeInsets.only(top: 20, left: 20),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           ElevatedButton(
              //             onPressed: () async {
              //               if (!_formKey.currentState!.validate()) {
              //                 return;
              //               }
              //
              //               _formKey.currentState!.save();
              //
              //               print(_name);
              //               print(_icon);
              //               print(_color);
              //               final newCategoryTodo = TodoCategory(
              //                   name: _name,
              //                   color: _color,
              //                   icon: _icon,
              //                   todoList: [],
              //                   createdTime: DateTime.now()
              //               );
              //
              //               await Provider.of<TodoProvider>(context, listen: false).addCategoryTodo(newCategoryTodo);
              //               Navigator.pop(context);
              //             },
              //             child: Text('Create'),
              //             style: ElevatedButton.styleFrom(
              //               // primary: AppColors.MintGreen,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //                 elevation: 0,
              //                 minimumSize: Size(221, 55),
              //                 textStyle: TextStyle(fontSize: 18)),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
