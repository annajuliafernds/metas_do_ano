import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/constants.dart';
import 'data/db_helper.dart';
import 'data/goal_repository.dart';
import 'blocs/goal/goal_bloc.dart';
import 'blocs/goal/goal_event.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = GoalRepository(db: DBHelper.instance, api: null);

    return RepositoryProvider.value(
      value: repo,
      child: BlocProvider(
        create: (_) => GoalBloc(repo)..add(LoadGoals()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Metas do Ano',
          theme: ThemeData(
            primaryColor: colorLilac,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: colorLilac,
              elevation: 0,
              centerTitle: true,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: colorLightBlue,
              primary: colorLilac,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorLilac,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
