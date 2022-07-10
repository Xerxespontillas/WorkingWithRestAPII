import 'dart:convert';

import '../Models/note.dart';
import '/Models/note_for_listing.dart';
import '/Models/api_response.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = "https://tq-notes-api-jkrgrdggbq-el.a.run.app/";

  static const headers = {
    'apiKey': "60cdd51e-5e6b-4563-96af-d33143d18f52"
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse('$API/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'Error occurred'));
  }
  Future<APIResponse<Note>> getNotes(String noteID) {
    return http.get(Uri.parse('$API/notes/'+ noteID)  , headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
       
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<Note>(
        error: true, errorMessage: 'Error occurred'));
  }
}