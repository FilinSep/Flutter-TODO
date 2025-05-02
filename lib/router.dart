import 'package:go_router/go_router.dart';
import 'package:todo/view/home_page/home_page.dart';
import 'package:todo/view/intro_page/intro_page.dart';
import 'package:todo/view/todo_page/todo_page.dart';

GoRouter appRouter = GoRouter(
  initialLocation: '/intro',
  routes: <GoRoute>[
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
      routes: [GoRoute(path: '/todo', builder: (context, state) => TodoPage())],
    ),
    GoRoute(path: '/intro', builder: (context, state) => IntroPage()),
  ],
);
