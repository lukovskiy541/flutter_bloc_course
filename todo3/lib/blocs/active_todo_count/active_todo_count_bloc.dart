import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo1/blocs/blocs.dart';
import 'package:todo1/models/todo_model.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  final int initialActiveTodoCount;
  final TodoListBloc todoListBloc;
  late final StreamSubscription todoListSubscription;
  ActiveTodoCountBloc(
      {required this.todoListBloc, required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(todo_count: initialActiveTodoCount)) {
    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      print(todoListState);

      final currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;
      add(CalculateActiveTodoCountEvent(
          activeTodoCount: currentActiveTodoCount));
    });

    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(todo_count: event.activeTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
