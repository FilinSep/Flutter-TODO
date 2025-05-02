import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/repo/icons/icons_repo.dart';
import 'package:todo/router.dart';
import 'package:todo/viewmodel/todo_list_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

bool getFirstTime(SharedPreferences prefs) {
  bool? ft = prefs.getBool('firstTime');

  if (ft == null) {
    prefs.setBool('firstTime', false);
    return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => TodoListViewModel(prefs: prefs, iconsRepo: IconsRepo()),
      child: MaterialApp.router(
        title: 'Simple TODO',
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        themeMode: ThemeMode.system,
        routerConfig: appRouter(getFirstTime(prefs)),
      ),
    );
  }
}
