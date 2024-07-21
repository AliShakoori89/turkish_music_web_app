part of 'audio_control_bloc.dart';

@immutable
class AudioControlState {}

class AudioControlInitial extends AudioControlState {}

class AudioPlayedState extends AudioControlState {}

class AudioPausedState extends AudioControlState {}

class AudioRepeatState extends AudioControlState {}

class AudioCompleteState extends AudioControlState {}

class AudioErrorState extends AudioControlState {}

class AudioLoadingNewSong extends AudioControlState {}