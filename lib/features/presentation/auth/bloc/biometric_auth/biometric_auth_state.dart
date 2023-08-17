abstract class BiometricAuthState {}

class LoadingState extends BiometricAuthState {}

class BiometricInitialState extends BiometricAuthState {}

class BiometricSuccessState extends BiometricAuthState {}

class BiometricFailureState extends BiometricAuthState {
  final String biometricPasswordErrorMessage;

  BiometricFailureState(this.biometricPasswordErrorMessage);
}
