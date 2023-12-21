import 'package:get_it/get_it.dart';

import '../core/network/dio_client.dart';
import '../data/datasource/remote/api_service.dart';
import '../data/repository/login/login_repository_impl.dart';
import '../data/repository/signup/signup_repository_impl.dart';
import '../data/repository/todo/todo_repository_impl.dart';
import '../domain/repository/login/login_repository.dart';
import '../domain/repository/signup/signup_repository.dart';
import '../domain/repository/todo/todo_repository.dart';
import '../domain/usecase/login/login_usecase.dart';
import '../domain/usecase/signup/signup_usecase.dart';
import '../domain/usecase/todo/todo_usecase.dart';
import '../presentation/providers/login/login_provider.dart';
import '../presentation/providers/signup/signup_provider.dart';
import '../presentation/providers/todo/add_edit_todo_provider.dart';
import '../presentation/providers/todo/todo_list_provider.dart';

class AppInjector {
  static final getIt = GetIt.instance;

  static Future<void> setup() async {
    getIt.registerSingleton(DioClient());

    _apiService();
    _repositories();
    _useCases();
    _providers();
  }

  static void _apiService() {
    getIt.registerLazySingleton<ApiService>(
      () => ApiService(
        dioClient: getIt(),
      ),
    );
  }

  static void _providers() {
    getIt.registerFactory(
      () => LoginProvider(
        loginUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => SignUpProvider(
        signUpUseCase: getIt(),
      ),
    );

    getIt.registerLazySingleton<TodoListProvider>(
      () => TodoListProvider(
        todoUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => AddEditTodoProvider(
        todoUseCase: getIt(),
      ),
    );
  }

  static void _useCases() {
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(
        loginRepository: getIt(),
      ),
    );

    getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(
        signUpRepository: getIt(),
      ),
    );

    getIt.registerLazySingleton<TodoUseCase>(
      () => TodoUseCase(
        todoRepository: getIt(),
      ),
    );
  }

  static void _repositories() {
    getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(
        apiService: getIt(),
      ),
    );
    getIt.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(
        apiService: getIt(),
      ),
    );
    getIt.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(
        apiService: getIt(),
      ),
    );
  }
}
