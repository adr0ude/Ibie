import 'package:flutter/material.dart';
import 'package:ibie/data/services/database_service.dart';
import 'package:provider/provider.dart';

// Pages
import 'package:ibie/ui/auth/view/welcome_page.dart';
import 'package:ibie/ui/auth/view/login_page.dart';
import 'package:ibie/ui/auth/view/instructors_pages/register_instructor_page.dart';
import 'package:ibie/ui/auth/view/instructors_pages/register_instructor_photo_page.dart';
import 'package:ibie/ui/auth/view/instructors_pages/success_instructor_page.dart';
import 'package:ibie/ui/auth/view/students_pages/register_student_page.dart';
import 'package:ibie/ui/auth/view/students_pages/preferences_page.dart';
import 'package:ibie/ui/auth/view/students_pages/register_student_photo_page.dart';
import 'package:ibie/ui/auth/view/students_pages/success_student_page.dart';
import 'package:ibie/ui/home/home_page.dart';
import 'package:ibie/ui/activity_form/view/activity_form_details_page.dart';
import 'package:ibie/ui/activity_form/view/activity_form_location_page.dart';
import 'package:ibie/ui/activity_form/view/activity_form_resources_page.dart';

// View Models
import 'package:ibie/ui/auth/viewModel/login_viewmodel.dart';
import 'package:ibie/ui/auth/viewModel/register_student_viewmodel.dart';
import 'package:ibie/ui/auth/viewModel/register_instructor_viewmodel.dart';
import 'package:ibie/ui/home/home_viewmodel.dart';
import 'package:ibie/ui/activity_form/activity_form_viewmodel.dart';

// Repositories
import 'package:ibie/data/repositories/login_repository.dart';
import 'package:ibie/data/repositories/sign_up_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/data/repositories/activity_repository.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/welcome': (context) => WelcomePage(),
  '/login': (context) => LoginPage(
    viewModel: LoginViewmodel(loginRepository: context.read<LoginRepository>()),
  ),
  '/registerStudent': (context) => RegisterStudentPage(
    viewModel: RegisterStudentViewmodel(
      signUpRepository: context.read<SignUpRepository>(),
    ),
  ),
  '/registerInstructor': (context) => RegisterInstructorPage(
    viewModel: RegisterInstructorViewmodel(
      signUpRepository: context.read<SignUpRepository>(),
    ),
  ),
  '/registerStudentPhoto': (context) {
    final viewModel =
        ModalRoute.of(context)!.settings.arguments as RegisterStudentViewmodel;
    return RegisterStudentPhotoPage(viewModel: viewModel);
  },
  '/registerInstructorPhoto': (context) {
    final viewModel =
        ModalRoute.of(context)!.settings.arguments
            as RegisterInstructorViewmodel;
    return RegisterInstructorPhotoPage(viewModel: viewModel);
  },
  '/preferences': (context) {
    final viewModel =
        ModalRoute.of(context)!.settings.arguments as RegisterStudentViewmodel;
    return PreferencesPage(viewModel: viewModel);
  },
  '/successStudent': (context) => SuccessStudentPage(),
  '/successInstructor': (context) => SuccessInstructorPage(),
  '/home': (context) => HomePage(
    viewModel: HomeViewmodel(
      userRepository: context.read<UserRepository>(),
      databaseService: context.read<DatabaseService>(),
    ),
  ),
  '/activityFormDetails': (context) => ActivityFormDetailsPage(
    viewModel: ActivityFormViewModel(
      activityRepository: context.read<ActivityRepository>(),
      userRepository: context.read<UserRepository>(),
    ),
  ),
  '/activityFormLocation': (context) {
    final viewModel =
        ModalRoute.of(context)!.settings.arguments as ActivityFormViewModel;
    return ActivityFormLocationPage(viewModel: viewModel);
  },
  '/activityFormResources': (context) {
    final viewModel =
        ModalRoute.of(context)!.settings.arguments as ActivityFormViewModel;
    return ActivityFormResourcesPage(viewModel: viewModel);
  },
};
