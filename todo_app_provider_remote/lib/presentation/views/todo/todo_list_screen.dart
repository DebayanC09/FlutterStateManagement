import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/functionality.dart';
import '../../../domain/entity/todo_entity.dart';
import '../../providers/todo/todo_list_provider.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_fab.dart';
import '../../widgets/custom_text.dart';
import 'add_edit_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  static const String name = "TodoListScreen";

  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late TodoListProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<TodoListProvider>(context, listen: false);

    _provider.getTodoList();
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
        body: Consumer<TodoListProvider>(
          builder: (context, consumerData, child) {
            return Stack(children: [
              _listWidget(
                  isListLoading: consumerData.isLoading,
                  todoList: consumerData.todoList),
              Visibility(
                visible: consumerData.isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ]);
          },
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
    Navigator.pushNamed(context, AddEditTodoScreen.name,
        arguments: {Constants.type: Constants.add});
  }

  void _updateTodo({required TodoEntity todoData}) {
    Navigator.pushNamed(context, AddEditTodoScreen.name, arguments: {
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
                  Navigator.of(context).pop();
                },
                child: const Text("CANCEL"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteTodo(todoData: todoData);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  void _deleteTodo({required TodoEntity todoData}) async {
    var response = await _provider.deleteTodo(todoData: todoData);
    showToast(message: response.message);
  }

  Widget _listWidget(
      {required bool isListLoading, required List<TodoEntity> todoList}) {
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
