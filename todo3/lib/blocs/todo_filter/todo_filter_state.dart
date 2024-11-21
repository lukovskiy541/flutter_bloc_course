part of 'todo_filter_bloc.dart';


class TodoFilterState extends Equatable {
  final Filter filter;

  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  TodoFilterState({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

