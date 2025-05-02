import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/router.dart';
import 'package:todo/viewmodel/todo_list_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListViewModel(),
      child: MaterialApp.router(
        title: 'Simple TODO',
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
