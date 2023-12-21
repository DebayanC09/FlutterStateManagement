import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/general_status.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/functionality.dart';
import '../../../di/injector.dart';
import '../../../domain/entity/todo_entity.dart';
import '../../providers/todo/add_edit_todo_provider.dart';
import '../../providers/todo/todo_list_provider.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_time_picker.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_text_field.dart';

class AddEditTodoScreen extends StatefulWidget {
  static const String name = "AddEditTodoScreen";

  const AddEditTodoScreen({super.key});

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  late AddEditTodoProvider _provider;
  late final Map<String, dynamic> arguments;

  @override
  void initState() {
    super.initState();
    _provider = AppInjector.getIt<AddEditTodoProvider>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      arguments = getArguments(context: context);
      String type = arguments[Constants.type];
      _provider.setType(type);
      if (type == Constants.update) {
        TodoEntity todoData = arguments[Constants.todoData];
        _provider.setDataToFields(todoData);
      }
      _provider.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: SafeArea(
        child: Consumer<AddEditTodoProvider>(
          builder: (context, consumerData, child) {
            return Scaffold(
              appBar: CustomAppBar(titleText: _provider.headerTitle),
              body: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child: ListView(
                    children: [
                      CustomTextField(
                        controller: _provider.titleController,
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
                        controller: _provider.descriptionController,
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
                        controller: _provider.dateTimeController,
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
                        controller: _provider.priorityController,
                        labelText: "Priority",
                        errorText: consumerData.priorityErrorText,
                        readOnly: true,
                        onChanged: (value) {
                          if (consumerData.priorityErrorText != null) {
                            consumerData.setPriorityErrorText(null);
                          }
                        },
                        onTap: () {
                          _showBottomSheet(
                            priorityErrorText: consumerData.priorityErrorText,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _button(
                        isLoading: consumerData.isLoading,
                      ),
                    ],
                  )),
            );
          },
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
                      _provider.setPriorityErrorText(null);
                    }
                    Navigator.pop(context);
                    _provider.priorityController.text = list[index];
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
          text: _provider.buttonText,
          onPressed: () {
            _validate();
          });
    }
  }

  void _validate() async {
    hideKeyboard(context);
    GeneralStatus response = GeneralStatus.idle();
    if (_provider.type == Constants.add) {
      response = await _provider.addTodo();
    } else if (_provider.type == Constants.update) {
      response = await _provider.updateTodo();
    }

    if (response.status == Status.success) {
      showToast(message: response.message);
      if (mounted) {
        Provider.of<TodoListProvider>(context, listen: false).updateList();
        Navigator.pop(context);
      }
    } else if (response.status == Status.error) {
      showToast(message: response.message);
    }
  }
}
