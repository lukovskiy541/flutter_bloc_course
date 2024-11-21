part of 'active_todo_count_bloc.dart';

class ActiveTodoCountState extends Equatable {
  final int todo_count;
  ActiveTodoCountState({
    required this.todo_count,
  });

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(todo_count: 0);
  }

  ActiveTodoCountState copyWith({
    int? todo_count,
  }) {
    return ActiveTodoCountState(
      todo_count: todo_count ?? this.todo_count,
    );
  }

  @override
  String toString() => 'ActiveTodoCountState(todo_count: $todo_count)';

  @override
  List<Object> get props => [todo_count];
}
