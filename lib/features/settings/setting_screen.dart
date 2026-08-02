import 'package:create_smart_notes/core/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dynamic horizontal padding ke liye screen size calculate karna
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                // Max width 600px set ki hai taaki tablet aur web par list stretch na ho
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width > 600 ? 24.0 : 10.0,
                    vertical: 10.0,
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.dark_mode),
                        title: const Text("Dark Mode"),
                        trailing: Consumer<ThemeProvider>(
                          builder: (context, provider, child) {
                            return Switch(
                              value: provider.isDark,
                              onChanged: (value) {
                                provider.toggleTheme(value);
                              },
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.info),
                        title: Text("About App"),
                        subtitle: Text(
                          "Create Smart Notes",
                        ),
                      ),
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Developer"),
                        subtitle: Text(
                          "Muhammad Ubaid",
                        ),
                      ),
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.privacy_tip),
                        title: Text("Privacy Policy"),
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