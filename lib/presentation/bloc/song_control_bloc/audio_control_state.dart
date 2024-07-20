part of 'audio_control_bloc.dart';

@immutable
sealed class AudioControlState {}

final class AudioControlInitial extends AudioControlState {}

final class AudioPlayedState extends AudioControlState {}

final class AudioPausedState extends AudioControlState {}

final class AudioRepeatState extends AudioControlState {}

final class AudioCompleteState extends AudioControlState {}

final class AudioErrorState extends AudioControlState {}

final class AudioLoadingNewSong extends AudioControlState {}