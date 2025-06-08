import 'package:equatable/equatable.dart';
import 'package:task_manager_app/models/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;

  const AddTask(this.title);

  @override
  List<Object> get props => [title];
}

class ToggleTask extends TaskEvent {
  final String taskId;

  const ToggleTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class DeleteTask extends TaskEvent {
  final String taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}