import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vrddwijkkutvbvrgyoqo.supabase.co',
    publishableKey: 'sb_publishable_CE8VloS1beGFQZ_vMyW-YQ_V1kCGvZD',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyber Pizza',
      theme: ThemeData.dark(),
      home: const LoginScreen(),
    );
  }
}