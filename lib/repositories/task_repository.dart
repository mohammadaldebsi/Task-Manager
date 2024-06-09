import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/task.dart';

class TaskRepository {
  final String _baseUrl = 'https://dummyjson.com/todos';

  Future<List<Task>> fetchTasks({required int userId}) async {
    final response = await http.get(Uri.parse('$_baseUrl/user/$userId'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('todos')) {
        final List<dynamic> todos = data['todos'];

        List<Task> tasks = [];

        for (var taskData in todos) {
          if (taskData is Map<String, dynamic>) {
            Task task = Task(
              id: taskData['id'] ?? 0,
              title: taskData['todo'] ?? '',
              completed: taskData['completed'] ?? false,
            );
            tasks.add(task);
          } else {
            throw Exception('Invalid task data format: $taskData');
          }
        }

        return tasks;
      } else {
        throw Exception('Response data is not in the expected format: $data');
      }
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<Task> addTask(Task task,int id) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'todo': task.title,
        'completed': task.completed,
        'userId': id,
      }),
    );

    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<Task> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'completed': task.completed,
      }),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
