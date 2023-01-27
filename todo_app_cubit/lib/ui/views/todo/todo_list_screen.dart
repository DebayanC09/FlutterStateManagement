import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/data/models/general_status.dart';
import 'package:todo_app_cubit/data/models/todo_model.dart';
import 'package:todo_app_cubit/ui/cubit/todo/todo_list_cubit.dart';
import 'package:todo_app_cubit/ui/cubit/todo/todo_list_state.dart';
import 'package:todo_app_cubit/utils/colors.dart';
import 'package:todo_app_cubit/utils/constants.dart';
import 'package:todo_app_cubit/utils/functionality.dart';
import 'package:todo_app_cubit/widgets/custom_appbar.dart';
import 'package:todo_app_cubit/widgets/custom_drawer.dart';
import 'package:todo_app_cubit/widgets/custom_text.dart';

import 'add_edit_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  static const String name = "TodoListScreen";

  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoListCubit _cubitProvider = TodoListCubit();

  @override
  void initState() {
    super.initState();
    _cubitProvider.getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubitProvider,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(titleText: "My Todo"),
          drawer: const CustomDrawer(),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                _addTodo();
              }),
          body: BlocConsumer<TodoListCubit, TodoListState>(
            listener: (context, state) {
              if (state.status == Status.delete) {
                showToast(message: state.message);
              }
            },
            builder: (context, state) {
              return Stack(children: [
                _listWidget(status: state.status, todoList: state.list),
                Visibility(
                  visible: state.status == Status.loading ? true : false,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }

  Widget _listItem({required TodoModel todoData}) {
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

  void _updateTodo({required TodoModel todoData}) {
    Navigator.pushNamed(context, AddEditTodoScreen.name, arguments: {
      Constants.type: Constants.update,
      Constants.todoData: todoData,
    });
  }

  void _showDeleteAlert({required TodoModel todoData}) {
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

  void _deleteTodo({required TodoModel todoData}) async {
    _cubitProvider.deleteTodo(todoId: todoData.id);
  }

  Widget _listWidget(
      {required Status status, required List<TodoModel> todoList}) {
    if (status != Status.loading && todoList.isEmpty) {
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
