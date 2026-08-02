import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModels {
  final String id;
  final String title;
  final String description;
  final String category;
  final bool isFavourite;
  final String imageUrl;
  final DateTime createdAt;

  NotesModels({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isFavourite,
    required this.imageUrl,
    required this.createdAt,
  });

  // Firestore mein Map bhejte waqt:
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'isFavourite': isFavourite,
      'imageUrl': imageUrl,
      // DateTime ko Firestore Timestamp banaya
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Firestore se Map milne par Model banate waqt:
  factory NotesModels.fromMap(Map<String, dynamic> map) {
    return NotesModels(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      isFavourite: map['isFavourite'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      // String aur Timestamp dono cases ko handle kiya gaya hai
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : map['createdAt'] is String
              ? DateTime.parse(map['createdAt'])
              : DateTime.now(),
    );
  }
}