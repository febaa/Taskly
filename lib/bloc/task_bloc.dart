import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_manager_app/bloc/task_event.dart';
import 'package:task_manager_app/bloc/task_state.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:uuid/uuid.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<ToggleTask>(_onToggleTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    final tasks = _taskBox.values.toList();
    emit(TaskLoadSuccess(tasks));
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    final task = Task(
      id: const Uuid().v4(),
      title: event.title,
    );
    await _taskBox.put(task.id, task);
    final tasks = _taskBox.values.toList();
    emit(TaskLoadSuccess(tasks));
  }

  Future<void> _onToggleTask(ToggleTask event, Emitter<TaskState> emit) async {
    final task = _taskBox.get(event.taskId);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      await task.save();
      final tasks = _taskBox.values.toList();
      emit(TaskLoadSuccess(tasks));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    await _taskBox.delete(event.taskId);
    final tasks = _taskBox.values.toList();
    emit(TaskLoadSuccess(tasks));
  }
}