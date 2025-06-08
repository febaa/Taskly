import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/bloc/theme_event.dart';
import 'package:task_manager_app/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeData.light())) {
    on<ToggleTheme>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final isDark = state.themeData.brightness == Brightness.dark;
    emit(ThemeState(isDark ? ThemeData.light() : ThemeData.dark()));
  }
}