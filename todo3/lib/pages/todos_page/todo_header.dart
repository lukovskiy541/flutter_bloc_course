import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('TODO', style: TextStyle(fontSize: 40),),
        BlocBuilder<ActiveTodoCountBloc, ActiveTodoCountState>(
          builder: (context, state) {
            return Text('${state.todo_count} iteams left', style: TextStyle(fontSize: 20, color: Colors.red,),);
          },
        ),
        // Text('${context.watch<ActiveTodoCountCubit>().state.todo_count} iteams left', style: TextStyle(fontSize: 20, color: Colors.red,),),
      ],
    );
  }
}