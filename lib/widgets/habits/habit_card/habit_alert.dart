import 'package:flutter/material.dart';

class HabitAlert extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Are you sure you wish to delete habit?"),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("DELETE")
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("CANCEL"),
        ),
      ],
    );
  }
}