import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/data/models/todo_model.dart';
import 'package:todo_app_getx/presentation/controller/todo/todo_list_controller.dart';
import '../../../core/state/general_status.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/functionality.dart';
import '../../controller/todo/add_edit_todo_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_time_picker.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_text_field.dart';

class AddEditTodoScreen extends StatefulWidget {
  const AddEditTodoScreen({super.key});

  static const String name = "/AddEditTodoScreen";

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final AddEditTodoController _controller = Get.find<AddEditTodoController>();
  final TodoListController _listController = Get.find<TodoListController>();
  String type = "";
  String title = "";
  late final Map<String, dynamic> arguments;
  late TodoModel todoData;

  @override
  void initState() {
    super.initState();

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
        appBar: CustomAppBar(titleText: title),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: ListView(
            children: [
              CustomTextField(
                controller: _controller.titleController,
                labelText: "Title",
                errorText: _controller.titleErrorText,
                onChanged: (value) {
                  if (_controller.titleErrorText != null) {
                    _controller.setTitleErrorText(null);
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: _controller.descriptionController,
                labelText: "Description",
                errorText: _controller.descriptionErrorText,
                onChanged: (value) {
                  if (_controller.descriptionErrorText != null) {
                    _controller.setDescriptionErrorText(null);
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDateTimePicker(
                controller: _controller.dateTimeController,
                labelText: "Date Time",
                errorText: _controller.dateTimeErrorText,
                onChanged: (value) {
                  if (_controller.dateTimeErrorText != null) {
                    _controller.setDateTimeErrorText(null);
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: _controller.priorityController,
                labelText: "Priority",
                errorText: _controller.priorityErrorText,
                readOnly: true,
                onChanged: (value) {
                  if (_controller.priorityErrorText != null) {
                    _controller.setPriorityErrorText(null);
                  }
                },
                onTap: () {
                  _showBottomSheet(
                    priorityErrorText: _controller.priorityErrorText,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              _button(
                isLoading: _controller.isLoading,
              ),
            ],
          ),
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
                      _controller.setPriorityErrorText(null);
                    }
                    _controller.priorityController.text = list[index];
                    Get.back();
                  },
                );
              });
        });
  }

  Widget _button({required bool isLoading}) {
    if (isLoading) {
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
    GeneralStatus response = GeneralStatus.idle();
    if (type == Constants.add) {
      response = await _controller.addTodo();
    } else if (type == Constants.update) {
      response = await _controller.updateTodo(
        id: todoData.id ?? "",
      );
    }

    if (response.status == Status.success) {
      showToast(message: response.message);
      if (mounted) {
        _listController.updateList();
        Get.back();
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
    _controller.titleController.text = todoData.title ?? "";
    _controller.descriptionController.text = todoData.description ?? "";
    _controller.dateTimeController.text = todoData.dateTime ?? "";
    _controller.priorityController.text = todoData.priority ?? "";
  }
}
