import 'dart:async';
import 'package:create_smart_notes/features/notes/models/notes_models.dart';
import 'package:create_smart_notes/features/notes/services/note_services.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  final NoteServices noteservice = NoteServices();

  List<NotesModels> note = [];
  List<NotesModels> get getnotes => note;
List<NotesModels> filteredNotes = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
bool showFavouriteOnly = false;

  // Stream Subscription reference keep karne ke liye
  StreamSubscription<List<NotesModels>>? _notesSubscription;

  // ================= GET NOTES (FIXED STREAM) =================
  void getNotes() {
    // Purana subscription clear karein agar exist karta ho
    _notesSubscription?.cancel();

    _isLoading = true;
    notifyListeners();

    _notesSubscription = noteservice.getNotes().listen(
      (notesData) {
       note = notesData;

if (showFavouriteOnly) {
  filteredNotes = note.where((element) {
    return element.isFavourite;
  }).toList();
} else {
  filteredNotes = note;
}
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _isLoading = false;
        notifyListeners();
        debugPrint("Error fetching notes stream: $error");
      },
    );
  }
  void searchNotes(String value) {

  if (value.isEmpty) {

    filteredNotes = note;

  } else {

    filteredNotes = note.where((element) {

      return element.title
          .toLowerCase()
          .contains(value.toLowerCase());

    }).toList();

  }

  notifyListeners();

}

  // ================= ADD NOTE =================
  Future<void> addNote(NotesModels noteItem) async {
    try {
      await noteservice.addnote(noteItem);
      // Note: Stream naturally UI update kar degi, global loading lock nahi hoga
    } catch (e) {
      debugPrint("Add Note Error: $e");
      rethrow;
    }
  }

  // ================= UPDATE NOTE =================
  Future<void> updateNote(NotesModels noteItem) async {
    try {
      await noteservice.updateNote(noteItem);
    } catch (e) {
      debugPrint("Update Note Error: $e");
      rethrow;
    }
  }

  // ================= DELETE NOTE =================
  Future<void> deleteNote(String noteId) async {
    try {
      await noteservice.deleteNote(noteId);
    } catch (e) {
      debugPrint("Delete Note Error: $e");
      rethrow;
    }
  }

  // ================= FAVOURITE =================
  Future<void> toggleFavourite(
    String noteId,
    bool currentValue,
  ) async {
    try {
      await noteservice.toggleFavourite(
        noteId,
        currentValue,
      );
    } catch (e) {
      debugPrint("Toggle Favourite Error: $e");
      rethrow;
    }
  }

  @override
  void dispose() {
    // Memory leak hone se bachayein
    _notesSubscription?.cancel();
    super.dispose();
  }
  void filterFavourite() {

  showFavouriteOnly = !showFavouriteOnly;

  if (showFavouriteOnly) {

    filteredNotes = note.where((element) {
      return element.isFavourite;
    }).toList();

  } else {

    filteredNotes = note;

  }

  notifyListeners();

}
void showAllNotes() {
  showFavouriteOnly = false;
  filteredNotes = note;
  notifyListeners();
}

void showFavouriteNotes() {
  showFavouriteOnly = true;

  filteredNotes = note.where((element) {
    return element.isFavourite;
  }).toList();

  notifyListeners();
}
}