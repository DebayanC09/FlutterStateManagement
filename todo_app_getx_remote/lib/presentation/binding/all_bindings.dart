import 'package:get/get.dart';
import 'package:todo_app_getx/core/network/dio_client.dart';
import 'package:todo_app_getx/data/datasource/remote/api_service.dart';
import 'package:todo_app_getx/data/repository/login/login_repository_impl.dart';
import 'package:todo_app_getx/data/repository/signup/signup_repository_impl.dart';
import 'package:todo_app_getx/data/repository/todo/todo_repository_impl.dart';
import 'package:todo_app_getx/domain/repository/login/login_repository.dart';
import 'package:todo_app_getx/domain/repository/signup/signup_repository.dart';
import 'package:todo_app_getx/domain/repository/todo/todo_repository.dart';
import 'package:todo_app_getx/domain/usecase/login/login_usecase.dart';
import 'package:todo_app_getx/domain/usecase/signup/signup_usecase.dart';
import 'package:todo_app_getx/domain/usecase/todo/todo_usecase.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    _dioClient();
    _apiService();
    _repositories();
    _useCases();
  }

  void _dioClient() {
    Get.lazyPut<DioClient>(
      () => DioClient(),
      fenix: true,
    );
  }

  void _apiService() {
    Get.lazyPut<ApiService>(
      () => ApiService(
        dioClient: Get.find(),
      ),
      fenix: true,
    );
  }

  void _repositories() {
    Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(
        apiService: Get.find(),
      ),
    );

    Get.lazyPut<SignUpRepository>(
          () => SignUpRepositoryImpl(
        apiService: Get.find(),
      ),
    );

    Get.lazyPut<TodoRepository>(
          () => TodoRepositoryImpl(
        apiService: Get.find(),
      ),
    );
  }

  void _useCases() {
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(
        loginRepository: Get.find(),
      ),
    );

    Get.lazyPut<SignUpUseCase>(
          () => SignUpUseCase(
        signUpRepository: Get.find(),
      ),
    );

    Get.lazyPut<TodoUseCase>(
          () => TodoUseCase(
        todoRepository: Get.find(),
      ),
    );
  }
}
