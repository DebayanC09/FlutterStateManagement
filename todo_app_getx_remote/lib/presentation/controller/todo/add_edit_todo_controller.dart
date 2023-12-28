import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/domain/entity/todo_entity.dart';
import 'package:todo_app_getx/domain/usecase/todo/todo_usecase.dart';

import '../../../core/state/general_status.dart';

class AddEditTodoController extends GetxController {
  late final TodoUseCase _todoUseCase;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final priorityController = TextEditingController();

  Rx<String?> _titleErrorText = null.obs;

  String? get titleErrorText => _titleErrorText.value;

  Rx<String?> _descriptionErrorText = null.obs;

  String? get descriptionErrorText => _descriptionErrorText.value;

  Rx<String?> _dateTimeErrorText = null.obs;

  String? get dateTimeErrorText => _dateTimeErrorText.value;

  Rx<String?> _priorityErrorText = null.obs;

  String? get priorityErrorText => _priorityErrorText.value;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  AddEditTodoController({required TodoUseCase todoUseCase}) {
    _todoUseCase = todoUseCase;
  }

  void setTitleErrorText(String? value) {
    _titleErrorText = RxnString(value);
  }

  void setDescriptionErrorText(String? value) {
    _descriptionErrorText = RxnString(value);
  }

  void setDateTimeErrorText(String? value) {
    _dateTimeErrorText = RxnString(value);
  }

  void setPriorityErrorText(String? value) {
    _priorityErrorText = RxnString(value);
  }

  void setIsLoading(bool value) {
    _isLoading.value = value;
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
      GeneralStatus<TodoEntity> response = await _todoUseCase.addTodo(
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority,
      );
      setIsLoading(false);
      return response;
    }
  }

  Future<GeneralStatus<TodoEntity>> updateTodo({
    required String id,
  }) async {
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
      GeneralStatus<TodoEntity> response = await _todoUseCase.updateTodo(
        id: id,
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority,
      );
      setIsLoading(false);
      return response;
    }
  }
}
