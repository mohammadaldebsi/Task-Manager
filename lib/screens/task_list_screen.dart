// TaskListScreen.dart
import 'package:flutter/material.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/screens/add_edit_task_screen.dart';
import 'package:task_manager/utils/component.dart';
import 'package:task_manager/utils/constants.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  final User user;
  final TaskRepository taskRepository = TaskRepository();

  TaskListScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: taskRepository.fetchTasks(userId: user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Task> tasks = snapshot.data ?? [];
            return Column(
              children: [
                Stack(
                  children: [
                    headContainer(size, 4),
                    Positioned(
                      left: 15,
                      right: 15,
                      bottom: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "My Tasks",
                            style: TextStyle(color: kWhiteColor, fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: kWhiteColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditTaskScreen(user: user),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(task: tasks[index], user: user);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
