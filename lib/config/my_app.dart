// lib/config/my_app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Routes
import 'package:ibie/config/routes.dart';

// Services
import 'package:ibie/data/services/auth_service.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:ibie/data/services/shared_preferences_service.dart';
import 'package:ibie/data/services/image_service.dart';
import 'package:ibie/data/services/storage_service.dart';

// Repositories
import 'package:ibie/data/repositories/login_repository.dart';
import 'package:ibie/data/repositories/sign_up_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/data/repositories/activity_repository.dart';

// First Page - WelcomePage
import 'package:ibie/ui/auth/view/welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthService()),
        Provider(create: (context) => DatabaseService()),
        Provider(create: (context) => SharedPreferencesService()),
        Provider(create: (context) => ImageService()),
        Provider(create: (context) => StorageService()),
        ChangeNotifierProvider(
          create: (context) => SignUpRepository(
            authService: context.read(),
            databaseService: context.read(),
            preferencesService: context.read(),
            storageService: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginRepository(
            authService: context.read(),
            databaseService: context.read(),
            preferencesService: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRepository(
            preferencesService: context.read(),
            databaseService: context.read(),
            authService: context.read(),
            imageService: context.read(),
            storageService: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityRepository(
            databaseService: context.read(),
            preferencesService: context.read()
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const WelcomePage(),
            routes: appRoutes,
          );
        },
      ),
    );
  }
}
