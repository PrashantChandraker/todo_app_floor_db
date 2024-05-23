import 'package:floor/floor.dart';
import 'package:todo_app_floor_db/database/notes_entity.dart';


@dao
abstract class MainDao{


  @Query("SELECT * FROM NoteEntity")
  Future<List<NoteEntity>> getAllNotes();

  @insert
  Future<void> insertNote(NoteEntity noteEntity);

  @update
  Future<void> updateNote(NoteEntity noteEntity);
  
  @delete
  Future<void> deleteNote(NoteEntity noteEntity);
}