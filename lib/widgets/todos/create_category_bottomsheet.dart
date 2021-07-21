import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class CreateCategoryBottomSheet extends StatefulWidget{

  @override
  _CreateCategoryBottomSheetState createState() => _CreateCategoryBottomSheetState();
}

class _CreateCategoryBottomSheetState extends State<CreateCategoryBottomSheet> {
  final inputController = TextEditingController();

  late String _name;
  late String _icon;
  final int _color = AppColors.SelectedColor.value;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
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
                      'New category',
                      style: TextStyle(
                        // color: AppColors.Graphite,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Icon'
                  ),
                  onSaved: (String? value) {
                    _icon = value!;
                  },
                ),
              ),

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
                            print(_icon);
                            print(_color);
                            final newCategoryTodo = TodoCategory(
                                name: _name,
                                color: _color,
                                icon: _icon,
                                todoList: [],
                                createdTime: DateTime.now()
                            );

                            await Provider.of<TodoProvider>(context, listen: false).addCategoryTodo(newCategoryTodo);
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