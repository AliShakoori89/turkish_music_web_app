import '../../../data/model/user_model.dart';

abstract class FetchUserEvent {
  List<Object> get props => [];
}

class GetCurrentUserEvent extends FetchUserEvent{}

class ExitAccountEvent extends FetchUserEvent{}
