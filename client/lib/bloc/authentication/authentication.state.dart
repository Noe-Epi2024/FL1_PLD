part of "authentication.bloc.dart";

@immutable
sealed class AuthenticationState {
  final bool stayLoggedIn;

  const AuthenticationState({this.stayLoggedIn = false});
}

@immutable
final class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState({super.stayLoggedIn = false});
}

@immutable
final class AuthenticationSuccessState extends AuthenticationState {
  const AuthenticationSuccessState({super.stayLoggedIn = false});
}

@immutable
final class AuthenticationFailureState extends AuthenticationState {
  final ErrorModel error;

  const AuthenticationFailureState(this.error, {super.stayLoggedIn = false});
}

@immutable
final class AuthenticationLoadingState extends AuthenticationState {
  const AuthenticationLoadingState({super.stayLoggedIn = false});
}
