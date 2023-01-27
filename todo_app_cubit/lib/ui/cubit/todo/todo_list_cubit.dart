import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/data/models/general_status.dart';
import 'package:todo_app_cubit/data/models/todo_model.dart';
import 'package:todo_app_cubit/data/repository/todo/todo_repository.dart';
import 'package:todo_app_cubit/ui/cubit/todo/todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(const TodoListState());

  void getTodoList() async {
    emit(state.copyWith(status: Status.loading));

    await TodoRepository.totoList();

    TodoRepository.todoListSC.listen((event) {
      final List<TodoModel> todoList = <TodoModel>[];
      todoList.clear();

      for (var element in event) {
        todoList.add(element);
      }

      emit(TodoListState(list: todoList));
    });

    // await emit.onEach<List<TodoModel>>(
    //   TodoRepository.todoListSC,
    //   onData: (list) => add(TodoListResponse(list: list)),
    // );
  }

  void deleteTodo({required String? todoId}) async {
    emit(state.copyWith(status: Status.loading));
    var response = await TodoRepository.deleteTodo(id: todoId ?? "");
    emit(
        state.copyWith(status: Status.delete, message: response.message ?? ""));
  }
}
