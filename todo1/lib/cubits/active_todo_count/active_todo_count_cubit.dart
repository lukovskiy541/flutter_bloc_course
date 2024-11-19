// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo1/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo1/models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final int initialActiveTodoCount;
  final TodoListCubit todoListCubit;
  late final StreamSubscription todoListSubscription;
  ActiveTodoCountCubit({required this.todoListCubit, required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(todo_count: initialActiveTodoCount)) {
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      print(todoListState);

      final currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;
      emit(state.copyWith(todo_count: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
