import 'package:todo_app_bloc/data/models/general_status.dart';

class AddEditTodoState {
  final Status status;
  final String? titleErrorText;
  final String? descriptionErrorText;
  final String? dateTimeErrorText;
  final String? priorityErrorText;
  final String? message;

  AddEditTodoState({
    this.status = Status.idle,
    this.titleErrorText,
    this.descriptionErrorText,
    this.dateTimeErrorText,
    this.priorityErrorText,
    this.message,
  });

  AddEditTodoState copyWith({
    Status? status,
    String? titleErrorText,
    String? descriptionErrorText,
    String? dateTimeErrorText,
    String? priorityErrorText,
    String? message,
  }) {
    return AddEditTodoState(
      status: status ?? this.status,
      titleErrorText: titleErrorText == null
          ? this.titleErrorText
          : titleErrorText.isEmpty
              ? null
              : titleErrorText,
      descriptionErrorText: descriptionErrorText == null
          ? this.descriptionErrorText
          : descriptionErrorText.isEmpty
              ? null
              : descriptionErrorText,
      dateTimeErrorText: dateTimeErrorText == null
          ? this.dateTimeErrorText
          : dateTimeErrorText.isEmpty
              ? null
              : dateTimeErrorText,
      priorityErrorText: priorityErrorText == null
          ? this.priorityErrorText
          : priorityErrorText.isEmpty
              ? null
              : priorityErrorText,
      message: message,
    );
  }
}
