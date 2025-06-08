import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/bloc/theme_bloc.dart';
import 'package:task_manager_app/bloc/theme_state.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Task Manager',
            theme: ThemeData(
              primaryColor: Colors.teal[600],
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.light(
                primary: Colors.teal[600]!,
                secondary: Colors.blueGrey[200]!,
                surface: Colors.white,
                onSurface: Colors.black87,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.light().textTheme.copyWith(
                      bodyLarge: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      bodyMedium: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                      headlineSmall: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
              ),
              cardTheme: CardThemeData(
                elevation: 4,
                shadowColor: Colors.teal.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.blueGrey[200],
                foregroundColor: Colors.teal[900],
                elevation: 8,
                shape: const CircleBorder(),
                iconSize: 28,
              ),
              checkboxTheme: CheckboxThemeData(
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.teal[600];
                  }
                  return Colors.grey[300];
                }),
                checkColor: WidgetStateProperty.all(Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.teal[600],
                foregroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              dialogTheme: DialogThemeData(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              primaryColor: Colors.teal[900],
              scaffoldBackgroundColor: Colors.grey[850],
              colorScheme: ColorScheme.dark(
                primary: Colors.teal[900]!,
                secondary: Colors.cyan[300]!,
                surface: Colors.grey[800]!,
                onSurface: Colors.white70,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme.copyWith(
                      bodyLarge: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                      bodyMedium: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
                      ),
                      headlineSmall: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
              ),
              cardTheme: CardThemeData(
                elevation: 4,
                shadowColor: Colors.teal.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.grey[800],
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.cyan[300],
                foregroundColor: Colors.teal[900],
                elevation: 8,
                shape: const CircleBorder(),
                iconSize: 28,
              ),
              checkboxTheme: CheckboxThemeData(
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.teal[900];
                  }
                  return Colors.grey[600];
                }),
                checkColor: WidgetStateProperty.all(Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.teal[900],
                foregroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              dialogTheme: DialogThemeData(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.grey[800],
              ),
            ),
            themeMode: state.themeData.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}