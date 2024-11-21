

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  final int initialActiveTodoCount;


  ActiveTodoCountBloc(
      {required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(todo_count: initialActiveTodoCount)) {
    

    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(todo_count: event.activeTodoCount));
    });
  }

  
}
