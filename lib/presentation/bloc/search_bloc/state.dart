import 'package:equatable/equatable.dart';
import '../../../data/model/singer_model.dart';

enum SearchWordStatus { initial, success, error, loading }

extension SearchWordStatusX on SearchWordStatus {
  bool get isInitial => this == SearchWordStatus.initial;
  bool get isSuccess => this == SearchWordStatus.success;
  bool get isError => this == SearchWordStatus.error;
  bool get isLoading => this == SearchWordStatus.loading;
}

class SearchWordState extends Equatable{

  const SearchWordState({
    required this.status,
    required this.especialWord,
  });

  static SearchWordState initial() => const SearchWordState(
    status: SearchWordStatus.initial,
    especialWord: <String>[],
  );

  final SearchWordStatus status;
  final List<String> especialWord;

  @override
  // TODO: implement props
  List<Object?> get props => [status, especialWord];

  SearchWordState copyWith({
    SearchWordStatus? status,
    List<String>? especialWord,
  }) {
    return SearchWordState(
      status: status ?? this.status,
      especialWord: especialWord ?? this.especialWord,
    );
  }
}