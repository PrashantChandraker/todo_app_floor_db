import 'package:flutter/material.dart';
import 'package:todo_app_floor_db/database/database.dart';
import 'package:todo_app_floor_db/screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder("Prashant_floor.db").build();


  runApp( MyApp(database: database,));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home_screen(database:database,)
    );
  }
}

