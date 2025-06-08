import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/bloc/task_event.dart';
import 'package:task_manager_app/bloc/task_state.dart';
import 'package:task_manager_app/bloc/theme_bloc.dart';
import 'package:task_manager_app/bloc/theme_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      context.read<TaskBloc>().add(AddTask(textController.text));
                      textController.clear();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial) {
                  context.read<TaskBloc>().add(LoadTasks());
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) => context.read<TaskBloc>().add(ToggleTask(task.id)),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => context.read<TaskBloc>().add(DeleteTask(task.id)),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('No tasks available'));
              },
            ),
          ),
        ],
      ),
    );
  }
}