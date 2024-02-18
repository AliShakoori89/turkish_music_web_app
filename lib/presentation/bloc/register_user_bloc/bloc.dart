import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/register_user_bloc/state.dart';
import '../../../domain/repositories/sign_up_user_repository.dart';
import 'event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  SignUpUserRepository signUpUserRepository = SignUpUserRepository();

  RegisterBloc(this.signUpUserRepository) : super(

      const RegisterState()){
    on<RegisterUserEvent>(_mapRegisterUserEventToState);
    on<RegisterUserViaOTPCodeEvent>(_mapRegisterUserViaOTPCodeEventToState);
  }

  void _mapRegisterUserEventToState(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));
      print("111111");

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

  void _mapRegisterUserViaOTPCodeEventToState(
      RegisterUserViaOTPCodeEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));

      final bool? registerStatus = await signUpUserRepository.registerUserViaOTPCode(event.email);

      emit(
        state.copyWith(
          status: RegisterStatus.success,
          registerStatus: registerStatus
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}