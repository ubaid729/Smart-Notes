import 'package:create_smart_notes/core/provider/theme_provider.dart';
import 'package:create_smart_notes/features/auth/provider/auth_provider.dart';
import 'package:create_smart_notes/features/notes/provider/notes_provider.dart';
import 'package:create_smart_notes/features/splash/screens/splash_screen.dart';
import 'package:create_smart_notes/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


  Future<void> main()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider(),),
      ChangeNotifierProvider(
      create: (context) => NotesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ],
    child: const MyApp(),
    ),
  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Smart Notes',

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode: themeProvider.themeMode,


      home: const SplashScreen(),

    );

  },
);
  }
}
     