import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/change_sign_up_to_login_page/state.dart';
import '../../../domain/repositories/change_sign_up_to_login_page_repository.dart';
import 'event.dart';

class ChangeSignUpToLoginPageBloc extends Bloc<ChangeSignUoToLoginEvent, ChangeSignUpToLoginPageState> {

  ChangeSignUpToLoginPageRepository changeSignUpToLoginPageRepository = ChangeSignUpToLoginPageRepository();

  ChangeSignUpToLoginPageBloc(this.changeSignUpToLoginPageRepository) : super(

    const ChangeSignUpToLoginPageState()){
    on<IsSignUpEvent>(_mapChangeSignUpToLoginPageEventToState);
  }

  void _mapChangeSignUpToLoginPageEventToState(
      IsSignUpEvent event, Emitter<ChangeSignUpToLoginPageState> emit) async {
    try {
      emit(state.copyWith(status: ChangeSignUpToLoginPageStatus.loading));
      final bool isSignUp = changeSignUpToLoginPageRepository.changePage(
          event.isSignUp);
      emit(
        state.copyWith(
          status: ChangeSignUpToLoginPageStatus.success,
          isSignUp: isSignUp,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeSignUpToLoginPageStatus.error));
    }
  }
}