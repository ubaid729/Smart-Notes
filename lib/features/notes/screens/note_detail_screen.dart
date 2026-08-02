import 'package:create_smart_notes/features/notes/models/notes_models.dart';
import 'package:flutter/material.dart';

class NoteDetailScreen extends StatelessWidget {
  final NotesModels note;

  const NoteDetailScreen({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic padding aur sizing ke liye screen size calculate kiya
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Detail"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  // Web aur Tablet screens par content width limit karne ke liye
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 600 ? 32.0 : 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          note.description,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}