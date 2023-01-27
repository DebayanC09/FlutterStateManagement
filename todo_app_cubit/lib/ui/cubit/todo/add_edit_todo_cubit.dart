import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/data/models/general_status.dart';
import 'package:todo_app_cubit/data/repository/todo/todo_repository.dart';
import 'package:todo_app_cubit/ui/cubit/todo/add_edit_todo_state.dart';

class AddEditTodoCubit extends Cubit<AddEditTodoState> {
  AddEditTodoCubit() : super(AddEditTodoState());

  void addTodo({
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  }) async {
    String? titleErrorText;
    String? descriptionErrorText;
    String? dateTimeErrorText;
    String? priorityErrorText;
    bool hasError = false;

    if (title.isEmpty) {
      titleErrorText = "Please enter title";
      hasError = true;
    }
    if (description.isEmpty) {
      descriptionErrorText = "Please enter description";
      hasError = true;
    }
    if (dateTime.isEmpty) {
      dateTimeErrorText = "Please enter date time";
      hasError = true;
    }
    if (priority.isEmpty) {
      priorityErrorText = "Please select priority";
      hasError = true;
    }

    if (hasError) {
      emit(AddEditTodoState(
        status: Status.validationError,
        titleErrorText: titleErrorText,
        descriptionErrorText: descriptionErrorText,
        dateTimeErrorText: dateTimeErrorText,
        priorityErrorText: priorityErrorText,
      ));
    } else {
      emit(AddEditTodoState(status: Status.loading));
      var response = await TodoRepository.addTodo(
          title: title,
          description: description,
          dateTime: dateTime,
          priority: priority);
      emit(
          AddEditTodoState(status: response.status, message: response.message));
    }
  }

  void setTitleErrorText({required String? titleErrorText}) {
    emit(state.copyWith(titleErrorText: titleErrorText));
  }

  void setDescriptionErrorText({required String? descriptionErrorText}) {
    emit(state.copyWith(descriptionErrorText: descriptionErrorText));
  }

  void setDateTimeErrorText({required String? dateTimeErrorText}) {
    emit(state.copyWith(dateTimeErrorText: dateTimeErrorText));
  }

  void setPriorityErrorText({required String? priorityErrorText}) {
    emit(state.copyWith(priorityErrorText: priorityErrorText));
  }

  void updateTodo({
    required String id,
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  }) async {
    String? titleErrorText;
    String? descriptionErrorText;
    String? dateTimeErrorText;
    String? priorityErrorText;
    bool hasError = false;

    if (title.isEmpty) {
      titleErrorText = "Please enter title";
      hasError = true;
    }
    if (description.isEmpty) {
      descriptionErrorText = "Please enter description";
      hasError = true;
    }
    if (dateTime.isEmpty) {
      dateTimeErrorText = "Please enter date time";
      hasError = true;
    }
    if (priority.isEmpty) {
      priorityErrorText = "Please select priority";
      hasError = true;
    }

    if (hasError) {
      emit(AddEditTodoState(
        status: Status.validationError,
        titleErrorText: titleErrorText,
        descriptionErrorText: descriptionErrorText,
        dateTimeErrorText: dateTimeErrorText,
        priorityErrorText: priorityErrorText,
      ));
    } else {
      emit(AddEditTodoState(status: Status.loading));
      var response = await TodoRepository.updateTodo(
        id: id,
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority,
      );
      emit(
          AddEditTodoState(status: response.status, message: response.message));
    }
  }
}
