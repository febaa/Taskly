import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/bloc/task_event.dart';
import 'package:task_manager_app/bloc/task_state.dart';
import 'package:task_manager_app/bloc/theme_bloc.dart';
import 'package:task_manager_app/bloc/theme_event.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  void _showAddTaskDialog(BuildContext context) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogTheme.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New Task',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Enter task title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  prefixIcon: Icon(
                    FontAwesomeIcons.tasks,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        context.read<TaskBloc>().add(AddTask(textController.text));
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.teal[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      'Add Task',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[900],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().scale(duration: 300.ms, curve: Curves.easeInOut).fadeIn()
    );
  }

  void _showDeleteTaskDialog(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        title: Text(
          'Delete Task',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTask(taskId));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 300.ms, curve: Curves.easeInOut)
    );
  }

  void _showToggleTaskDialog(BuildContext context, String taskId, bool isCompleted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        title: Text(
          isCompleted ? 'Mark as Incomplete' : 'Mark as Completed',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        content: Text(
          isCompleted
              ? 'Do you want to mark this task as incomplete?'
              : 'Do you want to mark this task as completed?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskBloc>().add(ToggleTask(taskId));
              Navigator.pop(context);
              setState(() {}); // Force UI refresh after dialog confirmation
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.teal[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.teal[900],
              ),
            ),
          ),
        ],
      ).animate().scale(duration: 300.ms, curve: Curves.easeInOut)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.clipboardList, // task/note style icon
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Memo',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      letterSpacing: 1.1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? FontAwesomeIcons.sun
                      : FontAwesomeIcons.moon,
                  color: Colors.white,
                ),
                onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial) {
                  context.read<TaskBloc>().add(LoadTasks());
                  return const SizedBox(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is TaskLoadSuccess) {
                  if (state.tasks.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.tasks,
                            size: 80,
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                          ).animate().fadeIn(duration: 600.ms).scale(),
                          const SizedBox(height: 16),
                          Text(
                            'No tasks yet, add some to get started!',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return Card(
                        key: ValueKey(task.id),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<TaskBloc>().add(ToggleTask(task.id));
                                setState(() {}); // Force UI refresh
                              }
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                            checkColor: Colors.white,
                          ).animate().fade(duration: 200.ms),
                          title: Text(
                            task.title,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                              color: task.isCompleted
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.trash,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _showDeleteTaskDialog(context, task.id),
                          ),
                          onTap: () => _showToggleTaskDialog(context, task.id, task.isCompleted),
                        ),
                      ).animate().slideY(
                            begin: 0.1,
                            end: 0,
                            duration: 300.ms,
                            curve: Curves.easeOut,
                          ).fadeIn(duration: 300.ms);
                    },
                  );
                }
                return const SizedBox(
                  height: 400,
                  child: Center(child: Text('No tasks available')),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(FontAwesomeIcons.plus, size: 28),
      ).animate().scale(duration: 300.ms, curve: Curves.easeInOut),
    );
  }
}