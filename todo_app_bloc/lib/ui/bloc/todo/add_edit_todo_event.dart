abstract class AddEditTodoEvent {}

class AddTodo extends AddEditTodoEvent {
  String title;
  String description;
  String dateTime;
  String priority;

  AddTodo({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
  });
}

class UpdateTodo extends AddEditTodoEvent {
  String id;
  String title;
  String description;
  String dateTime;
  String priority;

  UpdateTodo({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
  });
}

class TitleErrorText extends AddEditTodoEvent {
  final String? titleErrorText;

  TitleErrorText({required this.titleErrorText});
}

class DescriptionErrorText extends AddEditTodoEvent {
  final String? descriptionErrorText;

  DescriptionErrorText({required this.descriptionErrorText});
}

class DateTimeErrorText extends AddEditTodoEvent {
  final String? dateTimeErrorText;

  DateTimeErrorText({required this.dateTimeErrorText});
}

class PriorityErrorText extends AddEditTodoEvent {
  final String? priorityErrorText;

  PriorityErrorText({required this.priorityErrorText});
}
