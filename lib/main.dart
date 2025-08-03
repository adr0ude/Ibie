import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ibie/config/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // inicializa o Firebase

  await Supabase.initialize( // inicializa o Supabase
    url: 'https://nfimidphrxyefcyqlzla.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5maW1pZHBocnh5ZWZjeXFsemxhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQyMzg4MzIsImV4cCI6MjA2OTgxNDgzMn0.bK5W5lHhLt5VeAmhapqpyJBYki6Y6Mc-PUvO_oXcuTA',
  );

  runApp(const MyApp());
}