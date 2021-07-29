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
  IconData? _icon;
  late Color _color = Colors.red;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.cupertino);

    _icon = icon != null ? icon : null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      'New category',
                      style: TextStyle(
                          color: AppColors.MainText,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  style: TextStyle(color: AppColors.MainText),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.SelectedColor)),
                    hintText: 'Name',
                    hintStyle: TextStyle(color: AppColors.MainText),
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: _icon != null
                      ? Icon(_icon)
                      : Text('Choose icon',
                          style: TextStyle(color: AppColors.MainText)),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Choose color',
                      style: TextStyle(color: AppColors.MainText),
                    ),
                    ColorIndicator(
                      width: 44,
                      height: 44,
                      borderRadius: 4,
                      color: _color,
                      onSelectFocus: false,
                      onSelect: () async {
                        // Store current color before we open the dialog.
                        final Color colorBeforeDialog = _color;
                        // Wait for the picker to close, if dialog was dismissed,
                        // then restore the color we had before it was opened.
                        if (!(await ColorPickerDialog(
                          context: context,
                          onColorChanged: (Color color) {
                            setState(() => _color = color);
                          },
                          initialColor: _color
                        ).colorPickerDialog()
                        )) {
                          setState(() {
                            _color = colorBeforeDialog;
                          });
                        }
                      },
                    ),
                  ],
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
