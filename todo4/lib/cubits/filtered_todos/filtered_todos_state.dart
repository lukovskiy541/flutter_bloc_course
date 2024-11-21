// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'filtered_todos_cubit.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filtered_todos;
  FilteredTodosState({
    required this.filtered_todos,
  });

  factory FilteredTodosState.initial(){
    return FilteredTodosState(filtered_todos: [
    ]);
  }

  FilteredTodosState copyWith({
    List<Todo>? filtered_todos,
  }) {
    return FilteredTodosState(
      filtered_todos: filtered_todos ?? this.filtered_todos,
    );
  }

  @override
  String toString() => 'FilteredTodosState(filtered_todos: $filtered_todos)';

  @override
  List<Object> get props => [filtered_todos];
}
