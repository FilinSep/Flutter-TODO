import 'package:flutter/material.dart';

@immutable
class TodoItemModel {
  /// After editing To-do task, [TodoListViewModel] recreating [TodoItemModel] with
  /// new data, replace it in list of tasks and notifies listeners.
  final IconData icon;
  final String task;

  const TodoItemModel({required this.icon, required this.task});

  @override
  bool operator ==(Object other) {
    if (other is TodoItemModel) return task == other.task;
    return false;
  }
}
