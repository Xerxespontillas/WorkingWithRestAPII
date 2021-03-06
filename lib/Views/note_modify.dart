import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../Models/note.dart';
import '../Models/note_insert.dart';
import '../Services/notes_service.dart';

class NoteModify extends StatefulWidget {
  final String? noteID;

  NoteModify({this.noteID});

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get noteService => GetIt.instance<NotesService>();

  late String errorMessage;
  late Note note;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });

      noteService.getNotes(widget.noteID ?? '').then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'Error Occurred';
        }
        note = response.data!;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Note' : 'Create Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                      ),
                    ),
                    Container(
                      height: 8,
                    ),
                    TextField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: 'Note Content',
                      ),
                    ),
                    Container(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (isEditing) {
                              if (isEditing) {
                                setState(() {
                                  _isLoading = true;
                                });
                              }

                              final note = NoteManipulation(
                                  noteTitle: _titleController.text,
                                  noteContent: _contentController.text);
                              final result = await noteService.updateNote(widget.noteID!, note);
                              if (isEditing) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }

                              const title = "Done";
                              final text = result.error
                                  ? (result.errorMessage ?? 'An error occurred')
                                  : 'Your note is updated';

                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: const Text(title),
                                        content: Text(text),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'))
                                        ],
                                      )).then((data) {
                                if (result.data!) {
                                  Navigator.of(context).pop();
                                }
                              });
                            } else {
                              if (isEditing) {
                                setState(() {
                                  _isLoading = true;
                                });
                              }

                              final note = NoteManipulation(
                                  noteTitle: _titleController.text,
                                  noteContent: _contentController.text);
                              final result = await noteService.createNote(note);
                              if (isEditing) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }

                              const title = "Done";
                              final text = result.error
                                  ? (result.errorMessage ?? 'An error occurred')
                                  : 'Your note is created';

                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: const Text(title),
                                        content: Text(text),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'))
                                        ],
                                      )).then((data) {
                                if (result.data!) {
                                  Navigator.of(context).pop();
                                }
                              });
                            }
                          }),
                    )
                  ],
                ),
        ));
  }
}
