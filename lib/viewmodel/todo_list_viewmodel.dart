import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/todo_item_model.dart';
import 'package:todo/repo/icons/icons_repo.dart';

class TodoListViewModel extends ChangeNotifier {
  final List<TodoItemModel> todoItems = [];
  final SharedPreferences prefs;
  final IconsRepo iconsRepo;

  int get length => todoItems.length;

  void removeTask(String task) {
    for (var item in todoItems) {
      if (item.task == task) {
        todoItems.remove(item);
        notifyListeners();
        break;
      }
    }
  }

  bool canAddTask(String task) {
    if (task.isEmpty) return false;

    for (var item in todoItems) {
      if (item.task == task) {
        return false;
      }
    }
    return true;
  }

  void addTask(TodoItemModel model) {
    if (canAddTask(model.task)) {
      todoItems.add(model);
      notifyListeners();
    }
  }

  void replaceTask(String task, TodoItemModel model) {
    for (var item in todoItems) {
      if (item.task == task) {
        todoItems[todoItems.indexOf(item)] = model;
        notifyListeners();
        break;
      }
    }
  }

  TodoItemModel? getModel(String task) {
    for (var model in todoItems) {
      if (model.task == task) return model;
    }
  }

  // Working with Shared Preferences
  TodoListViewModel({required this.prefs, required this.iconsRepo}) {
    addListener(() {
      List<String> tasks = [];
      List<String> icons = [];
      for (var model in todoItems) {
        tasks.add(model.task);
        icons.add(iconsRepo.translateIcon(model.icon));
      }

      prefs.setStringList('tasks', tasks);
      prefs.setStringList('icons', icons);
    });

    List<String>? tasks = prefs.getStringList('tasks');
    List<String>? icons = prefs.getStringList('icons');

    if (tasks == null || tasks.isEmpty) return;

    for (final (index, task) in tasks.indexed) {
      addTask(TodoItemModel.fromPreferences(iconsRepo, task, icons![index]));
    }
  }
}
