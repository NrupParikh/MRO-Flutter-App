import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/shared_preferences/provider/mro_shared_preference_provider.dart';
import 'package:mro/features/presentation/auth/bloc/password_reset_schema_selection/password_reset_schema_selection_cubit.dart';
import 'package:mro/features/presentation/auth/pages/password_reset_schema_selection_screen.dart';

import 'config/shared_preferences/singleton/mro_shared_preference.dart';
import 'features/domain/api/providers/api_provider.dart';
import 'features/domain/api/singleton/api.dart';
import 'features/domain/repository/providers/mro_repository_provider.dart';
import 'features/domain/repository/singleton/mro_repository.dart';
import 'features/presentation/auth/bloc/login/login_cubit.dart';
import 'features/presentation/auth/bloc/password/password_cubit.dart';
import 'features/presentation/auth/bloc/password_reset/password_reset_cubit.dart';
import 'features/presentation/auth/pages/landing_screen.dart';
import 'features/presentation/auth/pages/login_screen.dart';
import 'features/presentation/auth/pages/password_reset_screen.dart';
import 'features/presentation/auth/pages/password_screen.dart';
import 'features/presentation/auth/pages/splash_screen.dart';
import 'features/presentation/home/pages/archive_screen.dart';
import 'features/presentation/home/pages/home_screen.dart';
import 'features/presentation/home/pages/my_approvals_screen.dart';
import 'features/presentation/home/pages/new_expenses_screen.dart';
import 'features/presentation/home/pages/setting_screen.dart';

void main() async {
  // Application works only in Portrait Mode by below mentioned code
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initializing a Shared Preference
  MroSharedPreference preference = MroSharedPreference();
  await preference.init();

  runApp(MyApp(
    preference: preference,
  ));
}

class MyApp extends StatelessWidget {
  final MroSharedPreference preference;

  MyApp({super.key, required this.preference});

  // Creating Singleton Instance of API and MroRepository
  final API _api = API();
  final MroRepository _mroRepository = MroRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MroSharedPreferenceProvider(
      preference: preference,
      child: APIProvider(
        api: _api,
        child: MroRepositoryProvider(
          mroRepository: _mroRepository,
          child: MaterialApp(
            title: 'MRO',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: AppConstants.routeSplash,
            routes: {
              AppConstants.routeSplash: (context) => const SplashScreen(),
              AppConstants.routeLanding: (context) => const LandingScreen(),
              AppConstants.routeLogin: (context) => BlocProvider(create: (context) => LogInCubit(), child: const LoginScreen()),
              AppConstants.routePassword: (context) =>
                  BlocProvider(create: (context) => PasswordCubit(), child: const PasswordScreen()),
              AppConstants.routePasswordReset: (context) =>
                  BlocProvider(create: (context) => PasswordResetCubit(), child: const PasswordResetScreen()),
              AppConstants.routePasswordResetSchemaSelection: (context) =>
                  BlocProvider(create: (context) => PasswordResetSchemaSelectionCubit(), child: const PasswordResetSchemaSelectionScreen()),
              AppConstants.routeHome: (context) => const HomeScreen(),
              AppConstants.routeNewExpenses: (context) => const NewExpensesScreen(),
              AppConstants.routeArchive: (context) => const ArchiveScreen(),
              AppConstants.routeMyApprovals: (context) => const MyApprovalsScreen(),
              AppConstants.routeSettings: (context) => const SettingsScreen(),
            },
          ),
        ),
      ),
    );
  }
}
