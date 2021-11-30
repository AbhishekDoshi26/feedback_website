import 'package:feedback_website/constants/config_constants.dart';
import 'package:feedback_website/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late Supabase supabase;
Future<void> main() async {
  supabase = await Supabase.initialize(
    url: SupabaseConstants.supabaseURL,
    anonKey: SupabaseConstants.supabaseKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Website - Abhishek Doshi',
      home: SplashScreen(),
    );
  }
}
