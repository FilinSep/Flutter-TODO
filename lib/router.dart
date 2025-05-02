import 'package:go_router/go_router.dart';
import 'package:todo/view/home_page/home_page.dart';
import 'package:todo/view/intro_page/intro_page.dart';
import 'package:todo/view/todo_page/todo_page.dart';

GoRouter appRouter(bool firstTime) => GoRouter(
  initialLocation: firstTime ? '/intro' : '/home',
  routes: <GoRoute>[
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: '/edit/:task',
          name: 'Edit',
          builder:
              (context, state) =>
                  TodoPage(creating: false, task: state.pathParameters['task']),
        ),
        GoRoute(
          path: '/create',
          name: 'Create',
          builder: (context, state) => TodoPage(creating: true),
        ),
      ],
    ),
    GoRoute(path: '/intro', builder: (context, state) => IntroPage()),
  ],
);
