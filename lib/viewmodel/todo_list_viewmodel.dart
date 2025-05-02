import 'package:flutter/material.dart';
import 'package:todo/model/todo_item_model.dart';

class TodoListViewModel extends ChangeNotifier {
  final List<TodoItemModel> todoItems = [];

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

  // Working with Shared Preferences
  TodoListViewModel() {
    addListener(() {});
  }
}
