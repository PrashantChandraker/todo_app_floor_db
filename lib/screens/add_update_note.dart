import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:todo_app_floor_db/database/database.dart';
import 'package:todo_app_floor_db/database/notes_entity.dart';

class AddUpdateNotes extends StatefulWidget {
  final AppDatabase database;
  final Function updateData;
  final NoteEntity? noteEntity;
  const AddUpdateNotes(
      {super.key,
      required this.database,
      required this.updateData,
      this.noteEntity});

  @override
  State<AddUpdateNotes> createState() => _AddUpdateNotesState();
}

class _AddUpdateNotesState extends State<AddUpdateNotes> {
  TextEditingController title_controller = TextEditingController();
  TextEditingController description_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.noteEntity != null) {
      setState(() {
        title_controller.text = widget.noteEntity!.title!;
        date_controller.text = widget.noteEntity!.date!;
        description_controller.text = widget.noteEntity!.description!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white70,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 64, 92),
        title: Text(
          widget.noteEntity == null ? "My Notes" : "Update Note",
          style: TextStyle(color: Colors.white70),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //////////////   title    ///////////////
                  TextFormField(
                    controller: title_controller,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Please Enter Title";
                      }
                      return null;
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                      fillColor: Colors.white70,
                      filled: true,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Type a Title",
                      // label: Center(child: Text("Title")),

                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //////////////  DESCRIPTION   ////////////////

                  TextFormField(
                    controller: description_controller,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Please Enter Description";
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Type your Description",
                      // label: Text("Description"),

                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /////////////  DATE     ////////////////////
                  Container(
                    color: Colors.white70,
                    child: TextFormField(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2040),
                                    initialDate: DateTime.now(),
                                    cancelText: "cancel",
                                    confirmText: "Ok",
                                    helpText: "Please Select a Date")
                                .then(
                              (value) {
                                if (value != null) {
                                  date_controller.text =
                                      DateFormat("yyyy/MM/dd").format(value);
                                }
                              },
                            );
                          },
                      maxLines: 1,
                      controller: date_controller,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please Enter Date";
                        }
                        return null;
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.all(10),
                        // label: Center(child: const Text("Date")),
                        hintText: "Date",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 5),
                        ),

                        suffixIcon: InkWell(
                          child: const Icon(Icons.date_range),
                          // onTap: () {
                          //   showDatePicker(
                          //           context: context,
                          //           firstDate: DateTime.now(),
                          //           lastDate: DateTime(2040),
                          //           initialDate: DateTime.now(),
                          //           cancelText: "cancel",
                          //           confirmText: "Ok",
                          //           helpText: "Please Select a Date")
                          //       .then(
                          //     (value) {
                          //       if (value != null) {
                          //         date_controller.text =
                          //             DateFormat("yyyy/MM/dd").format(value);
                          //       }
                          //     },
                          //   );
                          // },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  //////////////    SAVE     /////////////
                  Row(
                    mainAxisAlignment: widget.noteEntity == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          save();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .2,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 0, 64, 92),
                          ),
                          child: const Center(
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      //////////////    DELETE      ////////////////

                      widget.noteEntity == null
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                delete();
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .2,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.redAccent),
                                child: const Center(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// add/update function
  void save() async {
    if (key.currentState!.validate()) {
      if (widget.noteEntity == null) {
        NoteEntity note = NoteEntity(
          title: title_controller.text,
          date: date_controller.text,
          description: description_controller.text,
        );
        await widget.database.mainDao.insertNote(note);
        final snackbar = SnackBar(
          duration: Duration(seconds: 1),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Success",
            message: "Your Note Added",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackbar);
        Navigator.pop(context);
        widget.updateData();
      } else {
        NoteEntity note = NoteEntity(
            id: widget.noteEntity!.id,
            title: title_controller.text,
            date: date_controller.text,
            description: description_controller.text);
        await widget.database.mainDao.updateNote(note);
        final snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Success",
            message: "Your Note Updated",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackbar);
        Navigator.pop(context);
        widget.updateData();
      }
    }
  }

  void delete() async {
    await widget.database.mainDao.deleteNote(widget.noteEntity!);
    // showing snackbar
    final snackbar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
          title: "Delete",
          message: "Note Delete",
          contentType: ContentType.warning),
    );
    Navigator.pop(context);
    widget.updateData();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
