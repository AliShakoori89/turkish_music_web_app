part of 'song_bloc.dart';

@immutable
sealed class SongEvent {}

final class FetchNewSongs extends SongEvent {}

final class FetchAllSongs extends SongEvent {}
