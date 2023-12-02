import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/const/style.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/view/screens/add_notes_screen.dart';

void main() => runApp(
    const Directionality(textDirection: TextDirection.ltr, child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubitBloc()..createDataBase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: N.primarycolor),
            appBarTheme:
                const AppBarTheme(color: Color.fromARGB(255, 98, 2, 115))),
        home: AddNotes(),
      ),
    );
  }
}
