import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ibie/config/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // inicializa o Firebase
  runApp(const MyApp());
}