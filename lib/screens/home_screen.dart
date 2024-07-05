import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_floor_db/database/database.dart';
import 'package:todo_app_floor_db/database/notes_entity.dart';

import 'add_update_note.dart';

class Home_screen extends StatefulWidget {
  final AppDatabase database;
  const Home_screen({super.key, required this.database});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  // function to view all notes

  List<NoteEntity> allNotes = [];
  getAllNotes() async {
    List<NoteEntity> list = await widget.database.mainDao.getAllNotes();
    setState(() {
      allNotes = list.reversed.toList();
    });
  }

  @override
  void initState() {
    getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  //      actions: [
  //   PopupMenuButton<String>(
  //     icon: Icon(Icons.more_vert),
  //     onSelected: (value) {
  //       // Add your action handling code here
  //       if (value == 'Option 1') {
  //         // Handle Option 1
  //       } else if (value == 'Option 2') {
  //         // Handle Option 2
  //       } else if (value == 'Option 3') {
  //         // Handle Option 3
  //       }
  //     },
  //     itemBuilder: (BuildContext context) {
  //       return [
  //         PopupMenuItem<String>(
  //           value: 'Option 1',
  //           child: Text('Option 1'),
  //         ),
  //         PopupMenuItem<String>(
  //           value: 'Option 2',
  //           child: Text('Option 2'),
  //         ),
  //         PopupMenuItem<String>(
  //           value: 'Option 3',
  //           child: Text('Option 3'),
  //         ),
  //       ];
  //     },
  //   ),
  // ],
        leading:  Transform.scale(
    scale: 0.8,  // Adjust the scale factor as needed
    child: Image.asset('assets/app_icon.png'),
  ),
  
        backgroundColor: Color.fromARGB(255, 0, 64, 92),
        elevation: 10,
        title: const Text(
                  "PC Notes",
                  style: TextStyle(color: Colors.white70),
                ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 64, 92),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => AddUpdateNotes(
                        database: widget.database, updateData: getAllNotes)));
          }),
      body: SafeArea(
        child: allNotes.isEmpty
            ? Center(
                child: Lottie.asset('assets/empty_notes.json'),
              )
            : ListView.builder(
              // reverse: true,
                padding: EdgeInsets.only(
                  bottom: 80,
                ),
                itemCount: allNotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 8,
                      right: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black45, width: 2.0), // Add border here
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: add rounded corners
                    ),
                    child: ListTile(
                      tileColor: Colors.white70,
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => AddUpdateNotes(
                                    noteEntity: allNotes[index],
                                    database: widget.database,
                                    updateData: getAllNotes)));
                      },
                      title: Text(
                        allNotes[index].title ?? '',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(allNotes[index].description ?? ''),
                      leading: Text(allNotes[index].date ?? '',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 64, 92))),
                    ),
                  );
                }),
      ),
    );
  }
}
