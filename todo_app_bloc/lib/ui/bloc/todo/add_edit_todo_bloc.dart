import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/data/repository/todo/todo_repository.dart';
import 'package:todo_app_bloc/ui/bloc/todo/add_edit_todo_event.dart';
import 'package:todo_app_bloc/ui/bloc/todo/add_edit_todo_state.dart';

class AddEditTodoBloc extends Bloc<AddEditTodoEvent, AddEditTodoState> {
  AddEditTodoBloc() : super(AddEditTodoState()) {
    on<AddTodo>(_addTodo);
    on<UpdateTodo>(_updateTodo);
    on<TitleErrorText>(_setTitleErrorText);
    on<DescriptionErrorText>(_setDescriptionErrorText);
    on<DateTimeErrorText>(_setDateTimeErrorText);
    on<PriorityErrorText>(_setPriorityErrorText);
  }

  FutureOr<void> _addTodo(AddTodo event, Emitter<AddEditTodoState> emit) async {
    String title = event.title;
    String description = event.description;
    String dateTime = event.dateTime;
    String priority = event.priority;

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

  FutureOr<void> _setTitleErrorText(
      TitleErrorText event, Emitter<AddEditTodoState> emit) {
    emit(state.copyWith(titleErrorText: event.titleErrorText));
  }

  FutureOr<void> _setDescriptionErrorText(
      DescriptionErrorText event, Emitter<AddEditTodoState> emit) {
    emit(state.copyWith(descriptionErrorText: event.descriptionErrorText));
  }

  FutureOr<void> _setDateTimeErrorText(
      DateTimeErrorText event, Emitter<AddEditTodoState> emit) {
    emit(state.copyWith(dateTimeErrorText: event.dateTimeErrorText));
  }

  FutureOr<void> _setPriorityErrorText(
      PriorityErrorText event, Emitter<AddEditTodoState> emit) {
    emit(state.copyWith(priorityErrorText: event.priorityErrorText));
  }

  FutureOr<void> _updateTodo(
      UpdateTodo event, Emitter<AddEditTodoState> emit) async {
    String id = event.id;
    String title = event.title;
    String description = event.description;
    String dateTime = event.dateTime;
    String priority = event.priority;

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
