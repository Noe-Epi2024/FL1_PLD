part of "authentication.bloc.dart";

@immutable
sealed class AuthenticationEvent {}

@immutable
class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationLoginEvent(this.email, this.password);
}

@immutable
class AuthenticationRegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationRegisterEvent(this.email, this.password);
}

@immutable
class AuthenticationSetStayLoggedInEvent extends AuthenticationEvent {
  final bool stayLoggedIn;

  AuthenticationSetStayLoggedInEvent(this.stayLoggedIn);
}
