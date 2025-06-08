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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Container(
          width: screenWidth * 0.85, // Dialog width 85% of screen
          padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
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
                  fontSize: screenWidth * 0.045, // 18px base, scaled
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
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
                    size: screenWidth * 0.05, // Responsive icon size
                  ),
                ),
                style: GoogleFonts.poppins(fontSize: screenWidth * 0.04), // Responsive text
              ),
              SizedBox(height: screenHeight * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                        fontSize: screenWidth * 0.035, // Responsive text
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
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    child: Text(
                      'Add Task',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[900],
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().scale(duration: 300.ms, curve: Curves.easeInOut).fadeIn(),
    );
  }

  void _showDeleteTaskDialog(BuildContext context, String taskId) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            fontSize: screenWidth * 0.045, // Responsive title
          ),
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: GoogleFonts.poppins(fontSize: screenWidth * 0.04), // Responsive content
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                fontSize: screenWidth * 0.035,
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
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.01,
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 300.ms, curve: Curves.easeInOut),
    );
  }

  void _showToggleTaskDialog(BuildContext context, String taskId, bool isCompleted) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            fontSize: screenWidth * 0.045,
          ),
        ),
        content: Text(
          isCompleted
              ? 'Do you want to mark this task as incomplete?'
              : 'Do you want to mark this task as completed?',
          style: GoogleFonts.poppins(fontSize: screenWidth * 0.04),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                fontSize: screenWidth * 0.035,
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
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.01,
              ),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.teal[900],
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ],
      ).animate().scale(duration: 300.ms, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.25, // Responsive height (25% of screen)
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: screenHeight * 0.02),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.clipboardList,
                    color: Colors.white,
                    size: screenWidth * 0.05, // Responsive icon size
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Taskly',
                    style: GoogleFonts.orbitron(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.06, // Responsive title (24px base)
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
                      ? FontAwesomeIcons.moon
                      : FontAwesomeIcons.sun,
                  color: Colors.white,
                  size: screenWidth * 0.06, // Responsive icon size
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
                  return SizedBox(
                    height: screenHeight * 0.5,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is TaskLoadSuccess) {
                  if (state.tasks.isEmpty) {
                    return SizedBox(
                      height: screenHeight * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                          FontAwesomeIcons.tasks,
                          size: screenWidth * 0.2,
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                        )
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.easeInOut)
                        .fadeIn(),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'No tasks yet',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.045, // Responsive text
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
                    padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return Card(
                        key: ValueKey(task.id),
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<TaskBloc>().add(ToggleTask(task.id));
                                setState(() {}); // Force UI refresh
                              }
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ).animate().fade(duration: const Duration(milliseconds: 200)),
                          title: Text(
                            task.title,
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04, // ~16px on 400px screen
                              fontWeight: FontWeight.w500,
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                              color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black : Colors.white
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.trash,
                              color: Colors.redAccent,
                              size: screenWidth * 0.05, // Responsive icon
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
                return SizedBox(
                  height: screenHeight * 0.5,
                  child: Center(
                    child: Text(
                      'No tasks available',
                      style: GoogleFonts.poppins(fontSize: screenWidth * 0.04),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(
          FontAwesomeIcons.plus,
          size: screenWidth * 0.06, // Responsive icon size
        ),
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ).animate().scale(duration: 300.ms, curve: Curves.easeInOut),
    );
  }
}