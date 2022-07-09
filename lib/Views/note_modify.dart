import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
    final String ?noteID;
    NoteModify({this.noteID});

    bool get isEditing => noteID!=null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( isEditing == null ? 'Edit Note': 'Create Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Note Title',
                ),
              ),
              Container(
                height: 8,
              ),
              TextField(
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
                    child: Text('Submit',style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      if(isEditing){
                    ///
                      }
                      else{
                        ///
                      }
                      Navigator.of(context).pop();
                    }),
              )
            ],
          ),
        ));
  }
}
