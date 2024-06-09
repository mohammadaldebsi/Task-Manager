import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/task.dart';
import '../../models/user.dart';
import '../../repositories/task_repository.dart';
import '../../services/database_helper.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  late User _user;
  TaskBloc(this.taskRepository) : super(TaskInitial()) {
    _loadUser();
    on<FetchTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.fetchTasks(userId: _user.id);
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      try {
        final newTask = await taskRepository.addTask(event.task,_user.id);
        final currentState = state;
        if (currentState is TaskLoaded) {
          final updatedTasks = List<Task>.from(currentState.tasks)..add(newTask);
          emit(TaskLoaded(tasks: updatedTasks));
        }
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });

    // Inside TaskBloc class

    on<DeleteTask>((event, emit) async {
      try {
        await taskRepository.deleteTask(event.id);
        final currentState = state;
        if (currentState is TaskLoaded) {
          final updatedTasks = currentState.tasks.where((task) => task.id != event.id).toList();
          emit(TaskLoaded(tasks: updatedTasks));
        }
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        final updatedTask = await taskRepository.updateTask(event.task);
        final currentState = state;
        if (currentState is TaskLoaded) {
          final updatedTasks = currentState.tasks.map((task) {
            return task.id == updatedTask.id ? updatedTask : task;
          }).toList();
          emit(TaskLoaded(tasks: updatedTasks));
        }
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });
}
  void _loadUser() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      User? user = await databaseHelper.getUserFromLocalDatabase();
      if (user != null) {
        _user = user;
        add(FetchTasks());
      }
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }
  }
