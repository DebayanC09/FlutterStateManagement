import 'package:flutter/material.dart';
import 'package:todo_app_provider/data/models/general_status.dart';
import 'package:todo_app_provider/data/models/todo_model.dart';
import 'package:todo_app_provider/data/repository/todo/todo_repository.dart';

class TodoListProvider with ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  final List<TodoModel> _todoList = <TodoModel>[];

  List<TodoModel> get todoList => List.unmodifiable(_todoList);

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();

  }

  void getTodoList() async {
    await TodoRepository.totoList();
    updateList();
    setIsLoading(false);
  }

  void updateList(){
    _todoList.clear();
    _todoList.addAll(TodoRepository.todoList);
    notifyListeners();
  }

  Future<GeneralStatus> deleteTodo({required TodoModel todoData}) async {
    setIsLoading(true);
    var response = await TodoRepository.deleteTodo(id: todoData.id ?? "");
    setIsLoading(false);
    updateList();
    return response;
  }
}
