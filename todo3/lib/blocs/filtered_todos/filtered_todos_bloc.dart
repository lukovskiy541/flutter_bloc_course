import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo1/blocs/blocs.dart';
import 'package:todo1/models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoFilterSubscription;

  final List<Todo> initialTodos;

  final TodoListBloc todoListBloc;
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  FilteredTodosBloc({
    required this.todoListBloc,
    required this.todoSearchBloc,
    required this.todoFilterBloc,
    required this.initialTodos,
  }) : super(FilteredTodosState(filtered_todos: initialTodos)) {
    todoFilterSubscription =
        todoFilterBloc.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });
    todoSearchSubscription =
        todoSearchBloc.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });
    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
    on<CalculateFilteredTodosEvent>((event, emit) {
      emit(state.copyWith(filtered_todos: event.filteredTodos));
    });
  }
  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredTodos =
            todoListBloc.state.todos.where(((Todo t) => !t.completed)).toList();
        break;
      case Filter.completed:
        _filteredTodos =
            todoListBloc.state.todos.where(((Todo t) => t.completed)).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListBloc.state.todos;
        break;
    }

    if (todoSearchBloc.state.searchTerm != '') {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearchBloc.state.searchTerm))
          .toList();
    }
    add(CalculateFilteredTodosEvent(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    todoFilterSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}
