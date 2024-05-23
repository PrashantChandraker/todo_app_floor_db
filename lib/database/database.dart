import 'dart:async';

import 'package:floor/floor.dart';
import 'package:todo_app_floor_db/database/main_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_app_floor_db/database/notes_entity.dart';


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [NoteEntity])
abstract class AppDatabase extends FloorDatabase{


MainDao get mainDao;
}