import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/domain/entity/todo_entity.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/functionality.dart';
import '../../controller/todo/todo_list_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_fab.dart';
import '../../widgets/custom_text.dart';
import 'add_edit_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  static const String name = "/TodoListScreen";

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoListController _controller = Get.find<TodoListController>();

  @override
  void initState() {
    super.initState();
    _controller.getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(titleText: "My Todo"),
        drawer: const CustomDrawer(),
        floatingActionButton: CustomFab(
            icon: Icons.add,
            onPressed: () {
              _addTodo();
            }),
        body: Obx(
          () => Stack(children: [
            _listWidget(
                isListLoading: _controller.isLoading,
                todoList: _controller.todoList),
            Visibility(
              visible: _controller.isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _listItem({required TodoEntity todoData}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: todoData.title ?? "",
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(text: todoData.description ?? ""),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _updateTodo(todoData: todoData);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Color(AppColors.colorBlack),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    _showDeleteAlert(todoData: todoData);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color(AppColors.colorBlack),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: todoData.dateTime ?? ""),
                  CustomText(text: todoData.priority ?? ""),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addTodo() {
    Get.toNamed(AddEditTodoScreen.name,
        arguments: {Constants.type: Constants.add});
  }

  void _updateTodo({required TodoEntity todoData}) {
    Get.toNamed(AddEditTodoScreen.name, arguments: {
      Constants.type: Constants.update,
      Constants.todoData: todoData,
    });
  }

  void _showDeleteAlert({required TodoEntity todoData}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Do you want to delete?"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("CANCEL"),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  _deleteTodo(todoData: todoData);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  void _deleteTodo({required TodoEntity todoData}) async {
    var response = await _controller.deleteTodo(todoData: todoData);
    showToast(message: response.message);
  }

  Widget _listWidget({
    required bool isListLoading,
    required List<TodoEntity> todoList,
  }) {
    if (!isListLoading && todoList.isEmpty) {
      return const Center(child: Text("No List found"));
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return _listItem(todoData: todoList[index]);
        },
      );
    }
  }
}
