import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/constants.dart';
import 'data/db_helper.dart';
import 'data/goal_repository.dart';
// import 'data/api_service.dart';
import 'blocs/goal/goal_bloc.dart';
import 'blocs/goal/goal_event.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repo = GoalRepository(db: DBHelper.instance, api: null );

    return RepositoryProvider.value(
      value: repo,
      child: BlocProvider(
        create: (_) => GoalBloc(repo)..add(LoadGoals()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Metas do Ano',
          theme: ThemeData(
            primaryColor: COLOR_LILAC,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: COLOR_LILAC,
              elevation: 0,
              centerTitle: true,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: COLOR_LIGHT_BLUE,
              primary: COLOR_LILAC,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: COLOR_LILAC,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
