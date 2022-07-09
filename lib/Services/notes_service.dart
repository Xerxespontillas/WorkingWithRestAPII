import 'dart:convert';

import '/Models/note_for_listing.dart';
import '/Models/api_response.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const api = "https://tq-notes-api-jkrgrdggbq-el.a.run.app";

  static const headers = {
    'apiKey': 'c6c05908-8b50-4913-8c04-f9d94a316e9c'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse('$api/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime:item['latestEditDateTime'] != null ?
            DateTime.parse(item['latestEditDateTime']): null);
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'Error occurred'));
  }
}