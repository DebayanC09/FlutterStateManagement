import 'package:flutter/material.dart';
import 'package:todo_app_provider/data/models/general_status.dart';
import 'package:todo_app_provider/data/repository/todo/todo_repository.dart';

class AddEditTodoProvider with ChangeNotifier {
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
      return response;
    }
  }
}
