import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/widgets/utils/color_picker_dialog.dart';
import 'package:provider/provider.dart';

class CreateCategoryBottomSheet extends StatefulWidget {
  @override
  _CreateCategoryBottomSheetState createState() =>
      _CreateCategoryBottomSheetState();
}

class _CreateCategoryBottomSheetState extends State<CreateCategoryBottomSheet> {
  late String _name;
  IconData? _icon = Icons.settings;
  late Color _color = Colors.red;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.cupertino);

    setState(() => _icon = icon != null ? icon: _icon);
  }

  _pickColor() async {
    final Color colorBeforeDialog = _color;

    if (!(await ColorPickerDialog(
            context: context,
            onColorChanged: (Color color) {
              setState(() => _color = color);
            },
            initialColor: _color)
        .colorPickerDialog())) {
      setState(() {
        _color = colorBeforeDialog;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
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
                padding:
                    EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: AppColors.MainText),
                        decoration: InputDecoration(
                          hintText: 'New category name',
                          hintStyle: TextStyle(color: AppColors.GrayText),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        ),
                        onSaved: (String? value) {
                          _name = value!;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickIcon,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Choose icon',
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.MainText)),
                            Icon(
                              _icon,
                              color: _color,
                              size: 44,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickColor,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Choose color',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.MainText),
                            ),
                            ColorIndicator(
                              width: 44,
                              height: 44,
                              borderRadius: 4,
                              color: _color,
                            ),
                          ],
                        ),
                      ),
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

                              final newCategoryTodo = TodoCategory(
                                  name: _name,
                                  color: _color.value,
                                  icon: _icon!.codePoint,
                                  todoList: [],
                                  createdTime: DateTime.now());

                              await Provider.of<TodoProvider>(context,
                                      listen: false)
                                  .addCategoryTodo(newCategoryTodo);
                              Navigator.pop(context);
                            },
                            child: Text('Create'),
                            style: ElevatedButton.styleFrom(
                                // primary: AppColors.MintGreen,
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
            ],
          ),
        ),
      ),
    );
  }
}
