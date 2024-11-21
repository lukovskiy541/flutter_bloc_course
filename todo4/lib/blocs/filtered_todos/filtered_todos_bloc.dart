

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo1/models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {


  final List<Todo> initialTodos;

  FilteredTodosBloc({

    required this.initialTodos,
  }) : super(FilteredTodosState(filtered_todos: initialTodos)) {
  
    on<CalculateFilteredTodosEvent>((event, emit) {
      emit(state.copyWith(filtered_todos: event.filteredTodos));
    });
  }


 
}
