import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/state.dart';
import '../../../domain/repositories/sign_up_user_repository.dart';
import 'event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  SignUserRepository signUpUserRepository = SignUserRepository();

  UserBloc(this.signUpUserRepository) : super(

      const UserState()){
    on<RegisterUserEvent>(_mapRegisterUserEventToState);
    on<FirstLoginEvent>(_mapFirstLoginEventToState);
    on<SecondLoginEvent>(_mapSecondLoginEventToState);
    on<UserExistEvent>(_mapUserExistToState);
    on<UserLoggedInEvent>(_mapUserLoggedInToState);
    on<UserLoggedOutEvent>(_mapUserLoggedOutToState);
  }

  void _mapRegisterUserEventToState(
      RegisterUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      await signUpUserRepository.requestPublic(event.email);

      emit(
        state.copyWith(
          status: UserStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapFirstLoginEventToState(
      FirstLoginEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final bool? firstLoginStatus = await signUpUserRepository.firstLogin(event.email);

      emit(
        state.copyWith(
          status: UserStatus.success,
          firstRegisterStatus: firstLoginStatus
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapSecondLoginEventToState(
      SecondLoginEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final bool? secondLoginStatus = await signUpUserRepository.secondLogin(event.email, event.verficationToken);

      emit(
        state.copyWith(
            status: UserStatus.success,
            secondRegisterStatus: secondLoginStatus
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  //*********************************************************************

  void _mapUserExistToState(
      UserExistEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      await signUpUserRepository.getCurrentUser();

      emit(
        state.copyWith(
            status: UserStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapUserLoggedInToState(
      UserLoggedInEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      emit(
        state.copyWith(
          status: UserStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapUserLoggedOutToState(
      UserLoggedOutEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      emit(
        state.copyWith(
          status: UserStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }
}