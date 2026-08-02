import 'package:create_smart_notes/features/auth/screens/login_screen.dart';
import 'package:create_smart_notes/features/notes/provider/notes_provider.dart';
import 'package:create_smart_notes/features/settings/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // 1. Scrollable Content (Header & Menu Items)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        UserAccountsDrawerHeader(
                          currentAccountPicture: const CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 40,
                            ),
                          ),
                          accountName: Text(
                            user?.displayName ?? "No Name",
                          ),
                          accountEmail: Text(
                            user?.email ?? "No Email",
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text("Home"),
                          onTap: () {
                            context.read<NotesProvider>().showAllNotes();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.star),
                          title: const Text("Favourite"),
                          onTap: () {
                            context.read<NotesProvider>().showFavouriteNotes();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text("Settings"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. Fixed Bottom Logout Action
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          content: const Text(
                            "Are you sure you want to logout?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();

                                if (!context.mounted) return;

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}