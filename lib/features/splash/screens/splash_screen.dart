import 'dart:async';

import 'package:create_smart_notes/features/auth/screens/login_screen.dart';
import 'package:create_smart_notes/features/notes/screens/notes_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
      () {
        if (!mounted) return; // BuildContext mounted safety check

        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const NotesScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Screen height check karne ke liye
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Dynamic Logo Size (Chhoti screen par scale-down hoga aur bari par max 120px tak jayega)
                    FlutterLogo(
                      size: size.height * 0.15 > 120 ? 120 : size.height * 0.15,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}