import 'package:flutter/material.dart';
import 'package:todo_app_provider/data/models/general_status.dart';
import 'package:todo_app_provider/data/models/todo_model.dart';
import 'package:todo_app_provider/data/repository/todo/todo_repository.dart';
import 'package:todo_app_provider/utils/constants.dart';

class TodoProvider with ChangeNotifier {
  String? _titleErrorText;

  String? get titleErrorText => _titleErrorText;

  String? _descriptionErrorText;

  String? get descriptionErrorText => _descriptionErrorText;

  String? _dateTimeErrorText;

  String? get dateTimeErrorText => _dateTimeErrorText;

  String? _priorityErrorText;

  String? get priorityErrorText => _priorityErrorText;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isListLoading = true;

  bool get isListLoading => _isListLoading;

  final List<TodoModel> _todoList = <TodoModel>[];

  List<TodoModel> get todoList => _todoList;

  void setTitleErrorText(String? value) {
    _titleErrorText = value;
    notifyListeners();
  }

  void setDescriptionErrorText(String? value) {
    _descriptionErrorText = value;
    notifyListeners();
  }

  void setDateTimeErrorText(String? value) {
    _dateTimeErrorText = value;
    notifyListeners();
  }

  void setPriorityErrorText(String? value) {
    _priorityErrorText = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsListLoading(bool value) {
    _isListLoading = value;
    notifyListeners();
  }

  void getTodoList() async {
    var response = await TodoRepository.totoList();
    _todoList.clear();
    if (response.status == Status.success) {
      _todoList.addAll(response.data as List<TodoModel>);
    } else {
      _todoList.clear();
    }
    setIsListLoading(false);
  }

  Future<GeneralStatus> addTodo(
      {required String title,
      required String description,
      required String dateTime,
      required String priority}) async {
    if (title.isEmpty) {
      setTitleErrorText("Please enter title");
      return GeneralStatus.validationError();
    } else if (description.isEmpty) {
      setDescriptionErrorText("Please enter description");
      return GeneralStatus.validationError();
    } else if (dateTime.isEmpty) {
      setDateTimeErrorText("Please enter date time");
      return GeneralStatus.validationError();
    } else if (priority.isEmpty) {
      setPriorityErrorText("Please select priority");
      return GeneralStatus.validationError();
    } else {
      setIsLoading(true);
      var response = await TodoRepository.addTodo(
          title: title,
          description: description,
          dateTime: dateTime,
          priority: priority);
      setIsLoading(false);
      updateList(todoData: response.data as TodoModel, type: Constants.add);
      return response;
    }
  }

  Future<GeneralStatus> updateTodo(
      {required String id,
      required String title,
      required String description,
      required String dateTime,
      required String priority}) async {
    if (title.isEmpty) {
      setTitleErrorText("Please enter title");
      return GeneralStatus.validationError();
    } else if (description.isEmpty) {
      setDescriptionErrorText("Please enter description");
      return GeneralStatus.validationError();
    } else if (dateTime.isEmpty) {
      setDateTimeErrorText("Please enter date time");
      return GeneralStatus.validationError();
    } else if (priority.isEmpty) {
      setPriorityErrorText("Please select priority");
      return GeneralStatus.validationError();
    } else {
      setIsLoading(true);
      var response = await TodoRepository.updateTodo(
          id: id,
          title: title,
          description: description,
          dateTime: dateTime,
          priority: priority);
      setIsLoading(false);
      updateList(todoData: response.data as TodoModel, type: Constants.update);
      return response;
    }
  }

  Future<GeneralStatus> deleteTodo({required TodoModel todoData}) async {
    setIsListLoading(true);
    var response = await TodoRepository.deleteTodo(id: todoData.id ?? "");
    updateList(todoData: todoData, type: Constants.delete);
    setIsListLoading(false);
    return response;
  }

  void updateList({required TodoModel todoData, required String type}) {
    if (type == Constants.add) {
      _todoList.add(todoData);
    } else if (type == Constants.update) {
      int index = _todoList.indexWhere((element) => element.id == todoData.id);
      _todoList[index] = todoData;
    } else if (type == Constants.delete) {
      _todoList.removeWhere((element) => element.id == todoData.id);
    }
    notifyListeners();
  }
}
