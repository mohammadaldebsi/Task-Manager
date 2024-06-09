import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/utils/constants.dart';
import '../blocs/task/task_bloc.dart';
import '../models/task.dart';
import '../screens/add_edit_task_screen.dart';

class TaskItem extends StatefulWidget {
  final Task task;
final User user;
  const TaskItem({Key? key, required this.task, required this.user}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final TaskRepository _taskRepository=TaskRepository();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      leading: IconButton(onPressed: ()async {
        await _taskRepository.deleteTask(widget.task.id);
        setState(() {
        });
      }, icon: Icon(Icons.delete_outline,color: kPrimaryColor,)),
      trailing: Checkbox(
        value: widget.task.completed,
        onChanged: (value) async{
          await _taskRepository.updateTask(widget.task);

          setState(() {
  final updatedTask = widget.task.copyWith(completed: value);
  BlocProvider.of<TaskBloc>(context).add(UpdateTask(updatedTask));
});

        },
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTaskScreen(
                task: widget.task,
                user: widget.user,
              ),

            ));
      },
    );
  }
}
