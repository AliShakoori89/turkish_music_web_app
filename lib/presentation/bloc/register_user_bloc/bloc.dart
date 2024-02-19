import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/register_user_bloc/state.dart';
import '../../../domain/repositories/sign_up_user_repository.dart';
import 'event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  SignUserRepository signUpUserRepository = SignUserRepository();

  RegisterBloc(this.signUpUserRepository) : super(

      const RegisterState()){
    on<RegisterUserEvent>(_mapRegisterUserEventToState);
    on<FirstLoginEvent>(_mapFirstLoginEventToState);
    on<SecondLoginEvent>(_mapSecondLoginEventToState);
  }

  void _mapRegisterUserEventToState(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));

      await signUpUserRepository.requestPublic(event.email);

      emit(
        state.copyWith(
          status: RegisterStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }

  void _mapFirstLoginEventToState(
      FirstLoginEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));

      final bool? firstLoginStatus = await signUpUserRepository.firstLogin(event.email);


      emit(
        state.copyWith(
          status: RegisterStatus.success,
          firstRegisterStatus: firstLoginStatus
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }

  void _mapSecondLoginEventToState(
      SecondLoginEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));

      final bool? secondLoginStatus = await signUpUserRepository.secondLogin(event.email, event.verficationToken);


      emit(
        state.copyWith(
            status: RegisterStatus.success,
            secondRegisterStatus: secondLoginStatus
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}