import 'package:create_smart_notes/features/notes/screens/add_notes_screen.dart';
import 'package:create_smart_notes/features/notes/screens/edit_note.dart';
import 'package:create_smart_notes/features/notes/screens/note_detail_screen.dart';
import 'package:create_smart_notes/features/notes/widgets1/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/notes_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<NotesProvider>().getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic horizontal padding ke liye screen size evaluate karna
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const CustomDrawer(),
      // ================= APPBAR WITH FAVOURITE FILTER =================
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          Consumer<NotesProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: Icon(
                  provider.showFavouriteOnly
                      ? Icons.star
                      : Icons.star_border,
                ),
                onPressed: () {
                  provider.filterFavourite();
                },
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      // ================= BODY WITH RESPONSIVE LAYOUT =================
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                // Web/Tablet par list ko max 800px width limit mein center rakhta hai
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width > 600 ? 24.0 : 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: [
                      // 1. Search Bar Top Par
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Search Notes",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            context.read<NotesProvider>().searchNotes(value);
                          },
                        ),
                      ),

                      // 2. Filtered Notes List
                      Expanded(
                        child: Consumer<NotesProvider>(
                          builder: (context, provider, child) {
                            if (provider.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (provider.filteredNotes.isEmpty) {
                              return const Center(
                                child: Text("No Notes Found"),
                              );
                            }

                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: provider.filteredNotes.length,
                              itemBuilder: (context, index) {
                                final note = provider.filteredNotes[index];

                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => NoteDetailScreen(
                                            note: note,
                                          ),
                                        ),
                                      );
                                    },
                                    title: Text(note.title),
                                    subtitle: Text(
                                      note.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            note.isFavourite
                                                ? Icons.star
                                                : Icons.star_border,
                                          ),
                                          onPressed: () {
                                            provider.toggleFavourite(
                                              note.id,
                                              note.isFavourite,
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => EditNote(
                                                  note: note,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            provider.deleteNote(note.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
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