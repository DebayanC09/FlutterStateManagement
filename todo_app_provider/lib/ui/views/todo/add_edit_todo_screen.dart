import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/data/models/general_status.dart';
import 'package:todo_app_provider/data/models/todo_model.dart';
import 'package:todo_app_provider/ui/providers/todo/todo_provider.dart';
import 'package:todo_app_provider/utils/constants.dart';
import 'package:todo_app_provider/utils/functionality.dart';
import 'package:todo_app_provider/widgets/custom_appbar.dart';
import 'package:todo_app_provider/widgets/custom_button.dart';
import 'package:todo_app_provider/widgets/custom_date_time_picker.dart';
import 'package:todo_app_provider/widgets/custom_text_button.dart';
import 'package:todo_app_provider/widgets/custom_text_field.dart';

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

  late TodoProvider provider;
  late final Map<String, dynamic> arguments;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<TodoProvider>(context, listen: false);

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
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(title: title),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: Consumer<TodoProvider>(
              builder: (context, consumerData, child) {
                return ListView(
                  children: [
                    CustomTextField(
                      controller: titleController,
                      labelText: "Title",
                      errorText: consumerData.titleErrorText,
                      onChanged: (value) {
                        if (consumerData.titleErrorText != null) {
                          consumerData.setTitleErrorText(null);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: descriptionController,
                      labelText: "Description",
                      errorText: consumerData.descriptionErrorText,
                      onChanged: (value) {
                        if (consumerData.descriptionErrorText != null) {
                          consumerData.setDescriptionErrorText(null);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomDateTimePicker(
                      controller: dateTimeController,
                      labelText: "Date Time",
                      errorText: consumerData.dateTimeErrorText,
                      onChanged: (value) {
                        if (consumerData.dateTimeErrorText != null) {
                          consumerData.setDateTimeErrorText(null);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: priorityController,
                      labelText: "Priority",
                      errorText: consumerData.priorityErrorText,
                      readOnly: true,
                      onChanged: (value) {
                        if (consumerData.priorityErrorText != null) {
                          consumerData.setPriorityErrorText(null);
                        }
                      },
                      onTap: () {
                        _showBottomSheet(consumerData: consumerData);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _button(
                      consumerData: consumerData,
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }

  void _showBottomSheet({required TodoProvider consumerData}) {
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
                    if (consumerData.priorityErrorText != null) {
                      consumerData.setPriorityErrorText(null);
                    }
                    Navigator.pop(context);
                    priorityController.text = list[index];
                  },
                );
              });
        });
  }

  Widget _button({required TodoProvider consumerData}) {
    if (consumerData.isLoading) {
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

    GeneralStatus response = GeneralStatus.idle();
    if (type == Constants.add) {
      response = await provider.addTodo(
          title: title,
          description: description,
          dateTime: dateTime,
          priority: priority);
    } else if (type == Constants.update) {
      response = await provider.updateTodo(
          id: todoData.id ?? "",
          title: title,
          description: description,
          dateTime: dateTime,
          priority: priority);
    }

    if (response.status == Status.success) {
      showToast(message: response.message);
      if (mounted) {
        Navigator.pop(context);
      }
    } else if (response.status == Status.error) {
      showToast(message: response.message);
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
