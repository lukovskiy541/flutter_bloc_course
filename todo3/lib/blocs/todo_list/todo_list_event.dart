// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoListEvent {
  final String todoDesc;
  AddTodoEvent({
    required this.todoDesc,
  });

  @override
  String toString() => 'AddTodoEvent(todoDesc: $todoDesc)';

  @override
  List<Object> get props => [todoDesc];
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String todoDesc;
  EditTodoEvent({
    required this.id,
    required this.todoDesc,
  });

  @override
  String toString() => 'EditTodoEvent(id: $id, todoDesc: $todoDesc)';

  @override
  List<Object> get props => [id, todoDesc];
}

class ToggleTodoEvent extends TodoListEvent {
  final String id;
  ToggleTodoEvent({
    required this.id,
  });

  @override
  String toString() => 'ToggleTodoEvent(id: $id)';

  @override
  List<Object> get props => [id];
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo todo;
  RemoveTodoEvent({
    required this.todo,
  });

  @override
  String toString() => 'RemoveTodoEvent(todo: $todo)';

  @override
  List<Object> get props => [todo];
}
