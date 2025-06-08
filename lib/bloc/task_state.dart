import 'package:equatable/equatable.dart';
import 'package:task_manager_app/models/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  const TaskLoadSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}