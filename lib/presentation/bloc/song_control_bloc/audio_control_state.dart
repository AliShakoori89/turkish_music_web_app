part of 'audio_control_bloc.dart';

@immutable
class AudioControlState {}

class AudioControlInitial extends AudioControlState {}

class AudioPlayedState extends AudioControlState {
  final SongDataModel songModel;

  AudioPlayedState({required this.songModel});
}

class AudioPausedState extends AudioControlState {}

class AudioRepeatState extends AudioControlState {}

class AudioCompleteState extends AudioControlState {
  final SongDataModel songModel;

  AudioCompleteState({required this.songModel});
}

class AudioNextPlayState extends AudioControlState {}

class AudioRepeatStoppedState extends AudioControlState {}

class AudioPositionChangedState extends AudioControlState {
  final Duration position;
  AudioPositionChangedState({required this.position});
}

class AudioControlErrorState extends AudioControlState {
  final String errorMessage;
  AudioControlErrorState(this.errorMessage);
}