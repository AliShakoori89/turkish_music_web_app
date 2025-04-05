abstract class FetchUserEvent {
  List<Object> get props => [];
}

class GetCurrentUserEvent extends FetchUserEvent{}

class ExitAccountEvent extends FetchUserEvent{}
