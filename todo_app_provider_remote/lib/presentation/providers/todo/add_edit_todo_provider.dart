import 'package:flutter/material.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entity/todo_entity.dart';
import '../../../domain/usecase/todo/todo_usecase.dart';

class AddEditTodoProvider with ChangeNotifier {
  late final TodoUseCase _todoUseCase;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final priorityController = TextEditingController();

  String _type = "";

  late TodoEntity _todoData;

  String get type => _type;

  String get headerTitle {
    if (type == Constants.add) {
      return "Add Todo";
    } else if (type == Constants.update) {
      return "Update Todo";
    } else {
      return "";
    }
  }

  String get buttonText {
    if (type == Constants.add) {
      return "Add";
    } else if (type == Constants.update) {
      return "Update";
    } else {
      return "";
    }
  }

  void setType(String value) {
    _type = value;
  }

  AddEditTodoProvider({required TodoUseCase todoUseCase}) {
    _todoUseCase = todoUseCase;
  }

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

  Future<GeneralStatus<TodoEntity>> addTodo() async {
    String title = titleController.text.toString().trim();
    String description = descriptionController.text.toString().trim();
    String dateTime = dateTimeController.text.toString().trim();
    String priority = priorityController.text.toString().trim();

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
      var response = await _todoUseCase.addTodo(
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority,
      );
      setIsLoading(false);
      return response;
    }
  }

  Future<GeneralStatus<TodoEntity>> updateTodo() async {
    String title = titleController.text.toString().trim();
    String description = descriptionController.text.toString().trim();
    String dateTime = dateTimeController.text.toString().trim();
    String priority = priorityController.text.toString().trim();

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
      var response = await _todoUseCase.updateTodo(
        id: _todoData.id ?? "",
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority,
      );
      setIsLoading(false);
      return response;
    }
  }

  void setDataToFields(TodoEntity todoData) {
    _todoData = todoData;
    titleController.text = todoData.title ?? "";
    descriptionController.text = todoData.description ?? "";
    dateTimeController.text = todoData.dateTime ?? "";
    priorityController.text = todoData.priority ?? "";
  }

  void update() {
    notifyListeners();
  }
}
