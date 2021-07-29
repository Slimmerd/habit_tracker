import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/widgets/utils/color_picker_dialog.dart';
import 'package:provider/provider.dart';

class CategoryEditBottomSheet extends StatefulWidget {
  final TodoCategory todoCategory;
  final Function deleteFunction;

  CategoryEditBottomSheet(
      {Key? key, required this.todoCategory, required this.deleteFunction})
      : super(key: key);

  @override
  _CategoryEditBottomSheetState createState() =>
      _CategoryEditBottomSheetState();
}

class _CategoryEditBottomSheetState extends State<CategoryEditBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData? _icon;
  late Color _color;

  @override
  initState() {
    _color = Color(widget.todoCategory.color);
    super.initState();
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.cupertino);

    _icon = icon != null ? icon : null;
  }

  void updateTodo([String? name, IconData? icon, Color? color]) {
    var _todoCategory = new TodoCategory(
      id: widget.todoCategory.id,
      name: name != null ? name : widget.todoCategory.name,
      createdTime: widget.todoCategory.createdTime,
      color: color != null ? color.value : widget.todoCategory.color,
      icon: icon != null ? icon.codePoint : widget.todoCategory.icon,
      todoList: widget.todoCategory.todoList
    );

    Provider.of<TodoProvider>(context, listen: false).updateTodoCategory(_todoCategory);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<TodoProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.BackgroundMainColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
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
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 24,
                                      child: TextFormField(
                                          initialValue:
                                              widget.todoCategory.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.MainText),
                                          decoration: InputDecoration(
                                            hintText: 'Category name',
                                            hintStyle: TextStyle(
                                                color: AppColors.GrayText),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
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
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: _pickIcon,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: _icon != null
                                    ? Icon(_icon)
                                    : Text('Choose icon',
                                        style: TextStyle(
                                            color: AppColors.MainText)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                updateTodo(null, null, color);
                                                setState(() => _color = color);
                                              },
                                              initialColor: _color)
                                          .colorPickerDialog())) {
                                        setState(() {
                                          _color = colorBeforeDialog;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
      },
    );
  }
}
