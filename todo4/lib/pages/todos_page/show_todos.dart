// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo1/blocs/blocs.dart';
import 'package:todo1/models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  List<Todo> setFilteredTodos(
      Filter filter, List<Todo> todos, String searchTerm) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where(((Todo t) => !t.completed)).toList();
        break;
      case Filter.completed:
        _filteredTodos = todos.where(((Todo t) => t.completed)).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm != '') {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }
    return _filteredTodos;
  }

  Widget showBackground(int direction) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filtered_todos;

    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(listener: (context, state) {
          final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              state.todos,
              context.read<TodoSearchBloc>().state.searchTerm);
          context
              .read<FilteredTodosBloc>()
              .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
        }),
        BlocListener<TodoFilterBloc, TodoFilterState>(listener: (context, state) {
          final filteredTodos = setFilteredTodos(
              state.filter,
              context.read<TodoListBloc>().state.todos,
              context.read<TodoSearchBloc>().state.searchTerm);
          context
              .read<FilteredTodosBloc>()
              .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
        }),
        BlocListener<TodoSearchBloc, TodoSearchState>(listener: (context, state) {
          final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              context.read<TodoListBloc>().state.todos,
              state.searchTerm);
          context
              .read<FilteredTodosBloc>()
              .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
        }),
      ],
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              key: ValueKey(todos[index].id),
              onDismissed: (_) {
                context
                    .read<TodoListBloc>()
                    .add(RemoveTodoEvent(todo: todos[index]));
              },
              child: TodoItem(
                todo: todos[index],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey,
            );
          },
          itemCount: todos.length),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textEditingController.text = widget.todo.desc;
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit Todo'),
                  content: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () => {
                        setState(() {
                          _error =
                              textEditingController.text.isEmpty ? true : false;
                          if (!_error) {
                            context.read<TodoListBloc>().add(EditTodoEvent(
                                id: widget.todo.id,
                                todoDesc: textEditingController.text));
                            Navigator.pop(context);
                          }
                        })
                      },
                      child: Text('EDIT'),
                    ),
                  ],
                );
              });
            });
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
