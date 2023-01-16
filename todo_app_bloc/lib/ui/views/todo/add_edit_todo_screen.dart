import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/data/models/todo_model.dart';
import 'package:todo_app_bloc/ui/bloc/todo/add_edit_todo_bloc.dart';
import 'package:todo_app_bloc/ui/bloc/todo/add_edit_todo_event.dart';
import 'package:todo_app_bloc/ui/bloc/todo/add_edit_todo_state.dart';
import 'package:todo_app_bloc/utils/constants.dart';
import 'package:todo_app_bloc/utils/functionality.dart';
import 'package:todo_app_bloc/widgets/custom_appbar.dart';
import 'package:todo_app_bloc/widgets/custom_button.dart';
import 'package:todo_app_bloc/widgets/custom_date_time_picker.dart';
import 'package:todo_app_bloc/widgets/custom_text_button.dart';
import 'package:todo_app_bloc/widgets/custom_text_field.dart';

class AddEditTodoScreen extends StatefulWidget {
  static const String name = "AddEditTodoScreen";

  const AddEditTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final priorityController = TextEditingController();

  String type = "";
  String title = "";
  late TodoModel todoData;

  final AddEditTodoBloc _blocProvider = AddEditTodoBloc();
  late final Map<String, dynamic> arguments;

  @override
  void initState() {
    super.initState();

    AddEditTodoBloc();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      arguments = getArguments(context: context);
      type = arguments[Constants.type];
      if (type == Constants.update) {
        todoData = arguments[Constants.todoData];
      }
      title = _setTitle();

      setState(() {
        if (type == Constants.update) {
          _setDataToFields();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _blocProvider,
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(title: title),
          body: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: BlocConsumer<AddEditTodoBloc, AddEditTodoState>(
                listener: (context, state) {
                  if (state.status == Status.success) {
                    showToast(message: state.message);
                    Navigator.pop(context);
                  } else if (state.status == Status.error) {
                    showToast(message: state.message);
                  }
                },
                builder: (context, state) {
                  return ListView(
                    children: [
                      CustomTextField(
                        controller: titleController,
                        labelText: "Title",
                        errorText: state.titleErrorText,
                        onChanged: (value) {
                          if (state.titleErrorText != null) {
                            _blocProvider
                                .add(TitleErrorText(titleErrorText: ""));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: descriptionController,
                        labelText: "Description",
                        errorText: state.descriptionErrorText,
                        onChanged: (value) {
                          if (state.descriptionErrorText != null) {
                            _blocProvider.add(
                                DescriptionErrorText(descriptionErrorText: ""));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomDateTimePicker(
                        controller: dateTimeController,
                        labelText: "Date Time",
                        errorText: state.dateTimeErrorText,
                        onChanged: (value) {
                          if (state.dateTimeErrorText != null) {
                            _blocProvider
                                .add(DateTimeErrorText(dateTimeErrorText: ""));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: priorityController,
                        labelText: "Priority",
                        errorText: state.priorityErrorText,
                        readOnly: true,
                        onChanged: (value) {
                          if (state.priorityErrorText != null) {
                            _blocProvider
                                .add(PriorityErrorText(priorityErrorText: ""));
                          }
                        },
                        onTap: () {
                          _showBottomSheet(
                              priorityErrorText: state.priorityErrorText);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _button(state: state),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  void _showBottomSheet({required String? priorityErrorText}) {
    var list = <String>["High", "Medium", "Low"];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return CustomTextButton(
                  text: list[index],
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  onPressed: () {
                    if (priorityErrorText != null) {
                      _blocProvider
                          .add(PriorityErrorText(priorityErrorText: ""));
                    }
                    Navigator.pop(context);
                    priorityController.text = list[index];
                  },
                );
              });
        });
  }

  Widget _button({required AddEditTodoState state}) {
    if (state.status == Status.loading) {
      return const Center(
        child: SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return CustomButton(
          text: _setButtonText(),
          onPressed: () {
            _validate();
          });
    }
  }

  void _validate() async {
    hideKeyboard(context);
    String title = titleController.text.toString().trim();
    String description = descriptionController.text.toString().trim();
    String dateTime = dateTimeController.text.toString().trim();
    String priority = priorityController.text.toString().trim();

    if (type == Constants.add) {
      _blocProvider.add(AddTodo(
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority,
      ));
    } else if (type == Constants.update) {
      _blocProvider.add(UpdateTodo(
        id: todoData.id ?? "",
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority,
      ));
    }
  }

  String _setTitle() {
    if (type == Constants.add) {
      return "Add Todo";
    } else if (type == Constants.update) {
      return "Update Todo";
    } else {
      return "";
    }
  }

  String _setButtonText() {
    if (type == Constants.add) {
      return "Add";
    } else if (type == Constants.update) {
      return "Update";
    } else {
      return "";
    }
  }

  void _setDataToFields() {
    titleController.text = todoData.title ?? "";
    descriptionController.text = todoData.description ?? "";
    dateTimeController.text = todoData.dateTime ?? "";
    priorityController.text = todoData.priority ?? "";
  }
}
