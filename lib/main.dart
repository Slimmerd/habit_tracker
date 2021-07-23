import 'package:flutter/material.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:habit_tracker/providers/todo_provider.dart';
import 'package:habit_tracker/screens/details.dart';
import 'package:habit_tracker/screens/home.dart';
import 'package:habit_tracker/screens/settings.dart';
import 'package:habit_tracker/screens/todos.dart';
import 'package:habit_tracker/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'models/app_db.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HabitProvider()),
      ChangeNotifierProvider(create: (context) => TodoProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
      ),
      home: App(),
      routes: {
        '/details': (context) => DetailsScreen(),
        '/todos': (context) => TodosScreen()
      },
    );
  }
}

// Navigation bar implementation
class App extends StatefulWidget{

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    Home(),
    TodosScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    AppDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
      ),
      body: _children[_selectedIndex],
    );
  }
}