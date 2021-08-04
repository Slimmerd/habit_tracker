import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/colors.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key, required this.onTap, required this.selectedIndex})
      : super(key: key);

  final int selectedIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.GrayLight,
      selectedItemColor: AppColors.SelectedColor,
      unselectedItemColor: AppColors.MainText,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: selectedIndex,
      onTap: (int index) => onTap(index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Habits',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_turned_in),
          label: 'Todos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
