import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_smart_notes/features/notes/models/notes_models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // ================= ADD NOTE =================
  Future<void> addnote(NotesModels note) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final docRef = firestore
        .collection("users")
        .doc(user.uid)
        .collection("notes")
        .doc();

    final newNote = NotesModels(
      id: docRef.id,
      title: note.title,
      description: note.description,
      category: note.category,
      isFavourite: note.isFavourite,
      imageUrl: note.imageUrl,
      createdAt: note.createdAt,
    );

    await docRef.set(newNote.toMap());
  }

  // ================= GET NOTES =================
  Stream<List<NotesModels>> getNotes() {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    return firestore
        .collection("users")
        .doc(user.uid)
        .collection("notes")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return NotesModels.fromMap(data);
      }).toList();
    });
  }

  // ================= UPDATE NOTE =================
  Future<void> updateNote(NotesModels note) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("notes")
        .doc(note.id)
        .update(note.toMap());
  }

  // ================= DELETE NOTE =================
  Future<void> deleteNote(String noteId) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("notes")
        .doc(noteId)
        .delete();
  }

  // ================= TOGGLE FAVOURITE =================
  Future<void> toggleFavourite(
    String noteId,
    bool currentValue,
  ) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("notes")
        .doc(noteId)
        .update({
      "isFavourite": !currentValue,
    });
  }
}