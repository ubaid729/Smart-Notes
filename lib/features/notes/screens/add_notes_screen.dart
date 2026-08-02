import 'package:create_smart_notes/core/widgets/custom_button.dart';
import 'package:create_smart_notes/core/widgets/custom_textfield.dart';
import 'package:create_smart_notes/features/notes/models/notes_models.dart';
import 'package:create_smart_notes/features/notes/provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Screen dimensions calculate karne ke liye
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  // Web aur Tablet par Form ko max 500px tak limit rakhta hai
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 600 ? 32.0 : 20.0,
                      vertical: 20.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: titleController,
                            hintText: "Title",
                            prefixIcon: Icons.title,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter title";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: descriptionController,
                            hintText: "Description",
                            prefixIcon: Icons.description,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter description";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Consumer<NotesProvider>(
                            builder: (context, provider, child) {
                              if (provider.isLoading) {
                                return const CircularProgressIndicator();
                              }

                              return CustomButton(
                                text: "Save Note",
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    NotesModels note = NotesModels(
                                      id: "",
                                      title: titleController.text.trim(),
                                      description: descriptionController.text.trim(),
                                      category: "General",
                                      imageUrl: "",
                                      createdAt: DateTime.now(),
                                      isFavourite: false,
                                    );

                                    await provider.addNote(note);

                                    if (!context.mounted) return;

                                    // 1. Show Message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Note Added Successfully"),
                                      ),
                                    );

                                    // 2. Go Back to NotesScreen
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
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