// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo1/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo1/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo1/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo1/models/todo_model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final TodoListCubit todoListCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoFilterSubscription;

  final List<Todo> initialTodos;

  FilteredTodosCubit({
    required this.todoListCubit,
    required this.todoSearchCubit,
    required this.todoFilterCubit,
    required this.initialTodos,
  }) : super(FilteredTodosState(filtered_todos: initialTodos)) {
    todoFilterSubscription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });
    todoSearchSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodos = todoListCubit.state.todos
            .where(((Todo t) => !t.completed))
            .toList();
        break;
      case Filter.completed:
        _filteredTodos =
            todoListCubit.state.todos.where(((Todo t) => t.completed)).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListCubit.state.todos;
        break;
    }

    if (todoSearchCubit.state.searchTerm != '') {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filtered_todos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    todoFilterSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}
