import 'package:flutter/material.dart';

import '../../../core/state/general_status.dart';
import '../../../domain/entity/todo_entity.dart';
import '../../../domain/usecase/todo/todo_usecase.dart';

class TodoListProvider with ChangeNotifier {
  late final TodoUseCase _todoUseCase;

  TodoListProvider({required TodoUseCase todoUseCase}) {
    _todoUseCase = todoUseCase;
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  final List<TodoEntity> _todoList = <TodoEntity>[];

  List<TodoEntity> get todoList => List.unmodifiable(_todoList);

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getTodoList() async {
    await _todoUseCase.getTodoList();
    updateList();
    setIsLoading(false);
  }

  void updateList() {
    _todoList.clear();
    _todoList.addAll(_todoUseCase.todoList);
    notifyListeners();
  }

  Future<GeneralStatus<TodoEntity>> deleteTodo(
      {required TodoEntity todoData}) async {
    setIsLoading(true);
    var response = await _todoUseCase.deleteTodo(id: todoData.id ?? "");
    setIsLoading(false);
    updateList();
    return response;
  }
}
