import 'package:floor/floor.dart';

@Entity()
class NoteEntity{
  
  @PrimaryKey(autoGenerate: true)
   int? id;
   String? title;
  String? date;
  String? description;

  NoteEntity({ this.id,  this.title,  this.date, this.description});
}