import "package:bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:meta/meta.dart";

import "../../http/http.dart";
import "../../models/authentication.model.dart";
import "../../models/error.model.dart";
import "../../services/authentication.service.dart";

part "authentication.event.dart";
part "authentication.state.dart";

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationInitialState()) {
    void _onLogin(
      AuthenticationLoginEvent event,
      Emitter<AuthenticationState> emit,
    ) async {
      // emit loading
      emit(AuthenticationLoadingState(stayLoggedIn: state.stayLoggedIn));

      try {
        // request login from authentication service
        AuthenticationModel authentication =
            await AuthenticationService.login(event.email, event.password);
        Http.accessToken = authentication.accessToken;

        // emit success
        emit(AuthenticationSuccessState(stayLoggedIn: state.stayLoggedIn));
      } on ErrorModel catch (error) {
        // emit failure
        emit(
          AuthenticationFailureState(
            error,
            stayLoggedIn: state.stayLoggedIn,
          ),
        );
      } catch (exception) {}
    }

    void _onRegister(
      AuthenticationRegisterEvent event,
      Emitter<AuthenticationState> emit,
    ) async {
      emit(const AuthenticationLoadingState());

      try {
        AuthenticationModel model = await AuthenticationService.register(
          event.email,
          event.password,
        );
        Http.accessToken = model.accessToken;

        emit(const AuthenticationSuccessState());
      } on ErrorModel catch (error) {
        emit(AuthenticationFailureState(error));
      } catch (exception) {}
    }

    void _onSetStayLoggedIn(
      AuthenticationSetStayLoggedInEvent event,
      Emitter<AuthenticationState> emit,
    ) async {
      emit(AuthenticationInitialState(stayLoggedIn: event.stayLoggedIn));
    }

    on<AuthenticationLoginEvent>(_onLogin);

    on<AuthenticationRegisterEvent>(_onRegister);

    on<AuthenticationSetStayLoggedInEvent>(_onSetStayLoggedIn);
  }
}
