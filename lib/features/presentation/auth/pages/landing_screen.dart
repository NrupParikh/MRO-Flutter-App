import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:mro/config/shared_preferences/singleton/mro_shared_preference.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';
import 'package:mro/features/presentation/auth/bloc/biometric_auth/biometric_auth_cubit.dart';
import 'package:mro/features/presentation/auth/bloc/biometric_auth/biometric_auth_state.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/color_constants.dart';
import '../../../../config/constants/string_constants.dart';
import '../../../../config/shared_preferences/provider/mro_shared_preference_provider.dart';
import '../../../domain/repository/providers/mro_repository_provider.dart';
import '../../../widgets/my_custom_widget.dart';

GlobalKey<State> _dialogKey = GlobalKey<State>();

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late final LocalAuthentication auth;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
  }

  // // ================== BIOMETRIC AUTHENTICATION

  Future<void> authenticate(Connectivity connectivity, BiometricAuthCubit biometricAuthCubit, MroRepository? mroRepository,
      MroSharedPreference pref) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: "Please authenticate", options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true));

      if (didAuthenticate == true) {
        if (!mounted) return;

        var uNameWithSchemaId = pref.getString(AppConstants.prefKeyUserNameWithSchemaId);
        var userName = uNameWithSchemaId.split("|")[0];
        var schemaId = uNameWithSchemaId.split("|")[1];

        var password = pref.getString(AppConstants.prefKeyPassword);

        await connectivity.checkConnectivity().then((value) {
          if (value == ConnectivityResult.none) {
            biometricAuthCubit.submitForm(userName, password, schemaId, mroRepository!, pref, false);
          } else {
            biometricAuthCubit.submitForm(userName, password, schemaId, mroRepository!, pref, true);
          }
        });
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        Fluttertoast.showToast(msg: StringConstants.localizedReason);
      } else if (e.code == auth_error.lockedOut) {
        Fluttertoast.showToast(msg: StringConstants.lockedOut);
      } else if (e.code == auth_error.biometricOnlyNotSupported) {
        Fluttertoast.showToast(msg: StringConstants.biometricOnlyNotSupported);
      } else if (e.code == auth_error.notAvailable) {
        Fluttertoast.showToast(msg: StringConstants.notAvailable);
      } else if (e.code == auth_error.otherOperatingSystem) {
        Fluttertoast.showToast(msg: StringConstants.otherOperatingSystem);
      } else if (e.code == auth_error.passcodeNotSet) {
        Fluttertoast.showToast(msg: StringConstants.passcodeNotSet);
      } else if (e.code == auth_error.permanentlyLockedOut) {
        Fluttertoast.showToast(msg: StringConstants.permanentlyLockedOut);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pref = MroSharedPreferenceProvider.of(context)?.preference;
    var isBiometricEnabled = pref?.getBool(AppConstants.prefKeyIsBiometricEnabled);

    final BiometricAuthCubit biometricAuthCubit = context.read<BiometricAuthCubit>();
    Connectivity connectivity = Connectivity();
    return Scaffold(
      body: Center(
          child: BlocConsumer<BiometricAuthCubit, BiometricAuthState>(listenWhen: (context, state) {
        return state is BiometricSuccessState || state is BiometricFailureState || state is LoadingState;
      }, listener: (context, state) {
        if (state is BiometricSuccessState) {
          hideLoading(_dialogKey);
          Navigator.pushNamedAndRemoveUntil(context, AppConstants.routeHome, (route) => false);
        } else if (state is BiometricFailureState) {
          hideLoading(_dialogKey);
          displayDialog(context, state.biometricPasswordErrorMessage);
        } else if (state is LoadingState) {
          showLoading(context, _dialogKey);
        }
      }, buildWhen: (context, state) {
        return state is BiometricInitialState;
      }, builder: (context, state) {
        if (state is BiometricInitialState) {
          final mroRepository = MroRepositoryProvider.of(context)?.mroRepository;

          return Stack(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    ScanItLogoImage(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    buttonText: StringConstants.loginWithCredentials.toUpperCase(),
                    onPressed: () {
                      Navigator.pushNamed(context, AppConstants.routeLogin);
                    },
                    buttonBgColor: ColorConstants.blueThemeColor,
                  ),
                  if (isBiometricEnabled == true) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(StringConstants.or),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomElevatedButton(
                        buttonText: StringConstants.loginWithBioMetric.toUpperCase(),
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Currency Added in the database");
                          authenticate(connectivity, biometricAuthCubit, mroRepository, pref!);
                        },
                        buttonBgColor: ColorConstants.blueThemeColor)
                  ]
                ],
              ),
            ],
          );
        } else {
          return const Center(child: Text('Unknown state'));
        }
      })),
    );
  }

  void displayDialog(BuildContext context, String message) {
    var dialog = MyCustomAlertDialog(
      title: StringConstants.appFullName,
      description: message,
      onOkButtonPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      onCancelButtonPressed: () {},
      hasCancelButton: false,
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
