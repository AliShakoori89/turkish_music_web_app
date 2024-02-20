import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/authentication_bloc/state.dart';
import '../../service/authentication_service.dart';
import 'event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthenticationService authenticationService;

  AuthenticationBloc(this.authenticationService) : super(

      AuthenticationState.initial()){
    on<AppLoadedEvent>(_mapAppLoadedToState);
    on<UserLoggedInEvent>(_mapUserLoggedInToState);
    on<UserLoggedOutEvent>(_mapUserLoggedOutToState);
  }



  void _mapAppLoadedToState(
      AppLoadedEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));

      final currentUser = await authenticationService.getCurrentUser();

      print("currentUser                            "+currentUser.toString());

      emit(
        state.copyWith(
          status: AuthenticationStatus.success,
          user: currentUser
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AuthenticationStatus.error));
    }
  }

  void _mapUserLoggedInToState(
      UserLoggedInEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));
      await authenticationService.signInWithEmail(event.user.data!.email!);
      emit(
        state.copyWith(
            status: AuthenticationStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AuthenticationStatus.error));
    }
  }

  void _mapUserLoggedOutToState(
      UserLoggedOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));
      await authenticationService.signOut();
      emit(
        state.copyWith(
          status: AuthenticationStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AuthenticationStatus.error));
    }
  }
}