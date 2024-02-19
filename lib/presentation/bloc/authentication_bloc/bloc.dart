import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/authentication_bloc/state.dart';
import '../../service/authentication_service.dart';
import 'event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthenticationService authenticationService;

  AuthenticationBloc(this.authenticationService) : super(

      AuthenticationState.initial()){
    on<UserLoggedInEvent>(_mapUserLoggedInEventToState);
  }

  void _mapUserLoggedInEventToState(
      UserLoggedInEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));

      final currentUser = await authenticationService.getCurrentUser();

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
}