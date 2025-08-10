import 'package:flutter/material.dart';
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
import 'package:ibie/ui/home/view/home_page.dart';
import 'package:ibie/ui/profile/profile_page.dart';
import 'package:ibie/ui/my_activities/my_activities_page.dart';
import 'package:ibie/ui/activity_details/activity_details_page.dart';
import 'package:ibie/ui/activity_registration/view/activity_form_details_page.dart';
import 'package:ibie/ui/activity_registration/view/activity_form_location_page.dart';
import 'package:ibie/ui/activity_registration/view/activity_form_resources_page.dart';
import 'package:ibie/ui/instructor_details/instructor_details_page.dart';
import 'package:ibie/ui/activity_details/activity_details_instructor_page.dart';

// View Models
import 'package:ibie/ui/auth/view_model/login_viewmodel.dart';
import 'package:ibie/ui/auth/view_model/register_student_viewmodel.dart';
import 'package:ibie/ui/auth/view_model/register_instructor_viewmodel.dart';
import 'package:ibie/ui/home/view_model/home_viewmodel.dart';
import 'package:ibie/ui/profile/profile_viewmodel.dart';
import 'package:ibie/ui/my_activities/my_activities_viewmodel.dart';
import 'package:ibie/ui/activity_details/activity_details_viewmodel.dart';
import 'package:ibie/ui/activity_registration/activity_form_viewmodel.dart';
import 'package:ibie/ui/instructor_details/instructor_details_view_model.dart';

// Repositories
import 'package:ibie/data/repositories/login_repository.dart';
import 'package:ibie/data/repositories/sign_up_repository.dart';
import 'package:ibie/data/repositories/user_repository.dart';
import 'package:ibie/data/repositories/activity_repository.dart';

class ActivityDetailsArgs {
  final ActivityDetailsViewmodel viewModel;
  final String activityId;
  ActivityDetailsArgs(this.viewModel, this.activityId);
}

class ActivityFormDetailsArgs {
  final bool isEditing;
  final String activityId;

 ActivityFormDetailsArgs({
    this.isEditing = false,
    this.activityId = '',
  });
}

class ActivityFormLocationArgs {
  final ActivityFormViewmodel viewModel;
  final bool isEditing;

 ActivityFormLocationArgs({
    required this.viewModel,
    this.isEditing = false,
  });
}

class ActivityFormResourcesArgs {
  final ActivityFormViewmodel viewModel;
  final bool isEditing;

 ActivityFormResourcesArgs({
    required this.viewModel,
    this.isEditing = false,
  });
}

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
    final viewModel = ModalRoute.of(context)!.settings.arguments as RegisterStudentViewmodel;
    return RegisterStudentPhotoPage(viewModel: viewModel);
  },
  '/registerInstructorPhoto': (context) {
    final viewModel = ModalRoute.of(context)!.settings.arguments as RegisterInstructorViewmodel;
    return RegisterInstructorPhotoPage(viewModel: viewModel);
  },
  '/preferences': (context) {
    final viewModel = ModalRoute.of(context)!.settings.arguments as RegisterStudentViewmodel;
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
        activityRepository: context.read<ActivityRepository>(),
        userRepository: context.read<UserRepository>(),
      ),
      activityId: activityId,
    );
  },
  '/instructor': (context) {
    final instructorId = ModalRoute.of(context)!.settings.arguments as String;
    return InstructorDetailsPage(
      viewModel: InstructorDetailsViewModel(
        activityRepository: context.read<ActivityRepository>(),
      ),
      instructorId: instructorId,
    );
  },
  '/myActivities': (context) => MyActivitiesPage(
    viewModel: MyActivitiesViewmodel(
      activityRepository: context.read<ActivityRepository>(),
      userRepository: context.read<UserRepository>(),
    ),
  ),
  '/activityFormDetails': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as ActivityFormDetailsArgs;
    return ActivityFormDetailsPage(
      isEditing: args.isEditing,
      activityId: args.activityId,
      viewModel: ActivityFormViewmodel(
        activityRepository: context.read<ActivityRepository>(),
        userRepository: context.read<UserRepository>(),
      ),
    );
  },
  '/activityFormLocation': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as ActivityFormLocationArgs;
    return ActivityFormLocationPage(
      isEditing: args.isEditing,
      viewModel: args.viewModel,
    );
  },
  '/activityFormResources': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as ActivityFormResourcesArgs;
    return ActivityFormResourcesPage(
      isEditing: args.isEditing,
      viewModel: args.viewModel,
    );
  },
  '/activityDetailsInstructor': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as ActivityDetailsArgs;
    return ActivityDetailsInstructorPage(
      viewModel: args.viewModel,
      activityId: args.activityId,
    );
  },
};