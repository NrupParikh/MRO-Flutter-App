import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mro/config/constants/app_constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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

void main() {
  // Application works only in Portrait Mode by below mentioned code
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Creating Singleton Instance of API and MroRepository
  final API _api = API();
  final MroRepository _mroRepository = MroRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return APIProvider(
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
            AppConstants.routeLogin: (context) => BlocProvider(
                create: (context) => LogInCubit(), child: const LoginScreen()),
            AppConstants.routePassword: (context) => BlocProvider(
                create: (context) => PasswordCubit(),
                child: const PasswordScreen()),
            AppConstants.routePasswordReset: (context) => BlocProvider(
                create: (context) => PasswordResetCubit(),
                child: const PasswordResetScreen()),
            AppConstants.routeHome: (context) => const HomeScreen(),
            AppConstants.routeNewExpenses: (context) =>
                const NewExpensesScreen(),
            AppConstants.routeArchive: (context) => const ArchiveScreen(),
            AppConstants.routeMyApprovals: (context) =>
                const MyApprovalsScreen(),
            AppConstants.routeSettings: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
