// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_cubit.dart';

class TodoSearchState extends Equatable {
  final String searchTerm;
  TodoSearchState({
    required this.searchTerm,
  });

   factory TodoSearchState.initial() {
    return TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
