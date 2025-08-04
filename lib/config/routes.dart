import 'package:flutter/material.dart';
import 'package:ibie/ui/activities/general/activity_details_page.dart';
import 'package:ibie/ui/activities/general/activity_details_viewmodel.dart';
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
import 'package:ibie/ui/profile/profile_page.dart';
import 'package:ibie/ui/activities/my_activities/my_activities_page.dart';

// View Models
import 'package:ibie/ui/auth/viewModel/login_viewmodel.dart';
import 'package:ibie/ui/auth/viewModel/register_student_viewmodel.dart';
import 'package:ibie/ui/auth/viewModel/register_instructor_viewmodel.dart';
import 'package:ibie/ui/home/home_viewmodel.dart';
import 'package:ibie/ui/profile/profile_viewmodel.dart';
import 'package:ibie/ui/activities/my_activities/my_activities_viewmodel.dart';

// Repositories
import 'package:ibie/data/repositories/login_repository.dart';
import 'package:ibie/data/repositories/sign_up_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/data/repositories/activity_repository.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/welcome': (context) => WelcomePage(),
  '/login': (context) => LoginPage(
    viewModel: LoginViewmodel(
      loginRepository: context.read<LoginRepository>(),
      userRepository: context.read<UserRepository>(),
    ),
  ),
  '/registerStudent': (context) => RegisterStudentPage(
    viewModel: RegisterStudentViewmodel(
      signUpRepository: context.read<SignUpRepository>(),
      userRepository: context.read<UserRepository>(),
    ),
  ),
  '/registerInstructor': (context) => RegisterInstructorPage(
    viewModel: RegisterInstructorViewmodel(
      signUpRepository: context.read<SignUpRepository>(),
      userRepository: context.read<UserRepository>(),
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
      activityRepository: context.read<ActivityRepository>(),
    ),
  ),
  '/profile': (context) => ProfilePage(
    viewModel: ProfileViewmodel(userRepository: context.read<UserRepository>()),
  ),
  '/activity': (context) {
    final activityId = ModalRoute.of(context)!.settings.arguments as String;
    return ActivityDetailsPage(
      viewModel: ActivityDetailsViewmodel(
        userRepository: context.read<UserRepository>(),
        activityRepository: context.read<ActivityRepository>(),
      ),
      activityId: activityId,
    );
  },
  '/myActivities': (context) => MyActivitiesPage(
    viewModel: MyActivitiesViewmodel(
      userRepository: context.read<UserRepository>(),
      activityRepository: context.read<ActivityRepository>(),
    ),
  ),
};
