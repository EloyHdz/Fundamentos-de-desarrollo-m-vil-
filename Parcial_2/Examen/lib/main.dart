import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ffdzezswbxtjikwmautt.supabase.co',
    publishableKey:
        'sb_publishable_wId3uasc8swdhmxGnzsp9A_R51BebgN',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color backgroundColor =
      Color(0xFF0A0A0F);

  static const Color cardColor =
      Color(0xFF141421);

  static const Color neonBlue =
      Color(0xFF00F7FF);

  static const Color neonPink =
      Color(0xFFFF00FF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mis Lugares Favoritos',
      theme: ThemeData(
        brightness: Brightness.dark,

        scaffoldBackgroundColor:
            backgroundColor,

        primaryColor: neonBlue,

        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: cardColor,
          foregroundColor: neonBlue,
          elevation: 0,
        ),

        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(
          backgroundColor: neonPink,
          foregroundColor: Colors.white,
          elevation: 15,
        ),

        inputDecorationTheme:
            InputDecorationTheme(
          filled: true,
          fillColor: cardColor,

          labelStyle: const TextStyle(
            color: neonBlue,
          ),

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
          ),

          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide:
                const BorderSide(
              color: neonBlue,
            ),
          ),

          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide:
                const BorderSide(
              color: neonPink,
              width: 2,
            ),
          ),
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: neonPink,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                15,
              ),
            ),
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}