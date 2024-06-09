import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../lib/blocs/task/task_bloc.dart';
import '../lib/repositories/task_repository.dart';
import '../lib/models/task.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
  });

  group('TaskBloc', () {
    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when FetchTasks is added',
      build: () {
        when(mockTaskRepository.fetchTasks(limit: 10, skip: 0))
            .thenAnswer((_) async => [Task(id: 1, title: 'Test Task', completed: false)]);
        return TaskBloc(mockTaskRepository);
      },
      act: (bloc) => bloc.add(FetchTasks()),
      expect: () => [
        TaskLoading(),
        TaskLoaded(tasks: [Task(id: 1, title: 'Test Task', completed: false)])
      ],
    );
  });
}
