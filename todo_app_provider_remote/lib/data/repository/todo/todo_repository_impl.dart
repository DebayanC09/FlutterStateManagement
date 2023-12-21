import '../../../domain/repository/todo/todo_repository.dart';
import '../../datasource/remote/api_service.dart';
import '../../../core/state/general_status.dart';
import '../../../core/utils/constants.dart';
import '../../models/todo_list_response.dart';
import '../../models/todo_model.dart';
import '../../models/todo_response.dart';

class TodoRepositoryImpl implements TodoRepository{
  late final ApiService _apiService;

  TodoRepositoryImpl({required ApiService apiService}) {
    _apiService = apiService;
  }

  final List<TodoModel> _todoList = <TodoModel>[];

  @override
  List<TodoModel> get todoList => List.unmodifiable(_todoList);

  @override
  Future<GeneralStatus<List<TodoModel>>> totoList() async {
    TodoListResponse response = await _apiService.todoList();
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todoList != null) {
      _updateList(
        type: Constants.list,
        todoList: response.todoList,
      );
      return GeneralStatus.success(
        message: response.message,
        data: response.todoList,
      );
    } else {
      return GeneralStatus.error(
        message: response.message,
      );
    }
  }

  @override
  Future<GeneralStatus<TodoModel>> addTodo(
      {required String title,
      required String description,
      required String dateTime,
      required String priority}) async {
    TodoResponse response = await _apiService.addTodo(
      title: title,
      description: description,
      dateTime: dateTime,
      priority: priority,
    );
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todo != null) {
      _updateList(
        type: Constants.add,
        todoData: response.todo,
      );
      return GeneralStatus.success(
        message: response.message,
        data: response.todo,
      );
    } else {
      return GeneralStatus.error(
        message: response.message,
      );
    }
  }

  @override
  Future<GeneralStatus<TodoModel>> updateTodo({
    required String id,
    required String title,
    required String description,
    required String dateTime,
    required String priority,
  }) async {
    TodoResponse response = await _apiService.updateTodo(
        id: id,
        title: title,
        description: description,
        dateTime: dateTime,
        priority: priority);
    if (response.statusCode == "200" &&
        response.status == "1" &&
        response.todo != null) {
      _updateList(
        type: Constants.update,
        todoData: response.todo,
      );
      return GeneralStatus.success(
        message: response.message,
        data: response.todo,
      );
    } else {
      return GeneralStatus.error(
        message: response.message,
      );
    }
  }

  @override
  Future<GeneralStatus<TodoModel>> deleteTodo({required String id}) async {
    TodoResponse response = await _apiService.deleteTodo(id: id);
    if (response.statusCode == "200" && response.status == "1") {
      _updateList(
        type: Constants.delete,
        id: id,
      );
      return GeneralStatus.success(
        message: response.message,
        data: response.todo,
      );
    } else {
      return GeneralStatus.error(
        message: response.message,
      );
    }
  }

  _updateList({
    required String type,
    List<TodoModel>? todoList,
    TodoModel? todoData,
    String? id,
  }) {
    if (type == Constants.list) {
      if (todoList != null) {
        _todoList.clear();
        _todoList.addAll(todoList);
      }
    } else if (type == Constants.add) {
      if (todoData != null) {
        _todoList.add(todoData);
      }
    } else if (type == Constants.update) {
      if (todoData != null) {
        int index =
            _todoList.indexWhere((element) => element.id == todoData.id);
        _todoList[index] = todoData;
      }
    } else if (type == Constants.delete) {
      if (id != null) {
        _todoList.removeWhere((element) => element.id == id);
      }
    }
  }
}
