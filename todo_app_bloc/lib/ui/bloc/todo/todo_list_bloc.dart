import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/data/models/general_status.dart';
import 'package:todo_app_bloc/data/models/todo_model.dart';
import 'package:todo_app_bloc/data/repository/todo/todo_repository.dart';
import 'package:todo_app_bloc/ui/bloc/todo/todo_list_event.dart';
import 'package:todo_app_bloc/ui/bloc/todo/todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(const TodoListState()) {
    on<GetTodoList>(_getTodoList);
    on<TodoListResponse>(_todoListResponse);
    on<DeleteTodo>(_deleteTodo);
  }

  FutureOr<void> _getTodoList(
      TodoListEvent event, Emitter<TodoListState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await TodoRepository.totoList();
    await emit.onEach<List<TodoModel>>(
      TodoRepository.todoListSC,
      onData: (list) => add(TodoListResponse(list: list)),
    );
  }

  FutureOr<void> _todoListResponse(
      TodoListResponse event, Emitter<TodoListState> emit) {
    emit(TodoListState(status: Status.success, list: event.list));
  }

  FutureOr<void> _deleteTodo(
      DeleteTodo event, Emitter<TodoListState> emit) async {
    emit(state.copyWith(status: Status.loading));
    var response = await TodoRepository.deleteTodo(id: event.item.id ?? "");
    emit(
        state.copyWith(status: Status.delete, message: response.message ?? ""));
  }
}
