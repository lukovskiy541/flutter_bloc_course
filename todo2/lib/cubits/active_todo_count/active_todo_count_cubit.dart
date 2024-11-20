// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final int initialActiveTodoCount;

  ActiveTodoCountCubit({required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(todo_count: initialActiveTodoCount)) {}

  void calculateActiveTodoCount(int activeTodoCount) {
    emit(state.copyWith(todo_count : activeTodoCount));
  }
}
