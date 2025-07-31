// lib/config/my_app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Routes
import 'package:ibie/config/routes.dart';

// Services
import 'package:ibie/data/services/auth_service.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:ibie/data/services/shared_preferences_service.dart';

// Repositories
import 'package:ibie/data/repositories/login_repository.dart';
import 'package:ibie/data/repositories/sign_up_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';

// First Page - WelcomePage
import 'package:ibie/ui/auth/view/welcome_page.dart'; // Importa a WelcomePage
// Importa a tela GerenciarAtividadesScreen (mantém o import, mesmo se não for a home)
import 'package:ibie/ui/activity_manager/gerenciar_atividades_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthService()),
        Provider(create: (context) => DatabaseService()),
        Provider(create: (context) => SharedPreferencesService()),
        ChangeNotifierProvider(
          create: (context) => SignUpRepository(
            authService: context.read(),
            databaseService: context.read(),
            preferencesService: context.read(),
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
          create: (context) =>
              UserRepository(preferencesService: context.read()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // AQUI VOCÊ VOLTA PARA A WelcomePage
            home: const WelcomePage(), // <--- Mude de volta para WelcomePage!
            // home: const GerenciarAtividadesScreen(), // Comente ou remova esta linha
            routes: appRoutes,
          );
        },
      ),
    );
  }
}
