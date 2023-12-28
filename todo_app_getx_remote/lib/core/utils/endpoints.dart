class Endpoints {
  static const bool _isLive = true;

  static String baseURL() {
    if (_isLive) {
      return "https://cyan-super-piglet.cyclic.app/";
    } else {
      return "http://192.168.0.9:5000/";
    }
  }

  static String userLogin = "users/login";
  static String userRegister = "users/register";
  static String refreshToken = "auth/refreshToken";
  static String addTodo = "todo/addTodo";
  static String updateTodo = "todo/updateTodo";
  static String deleteTodo = "todo/deleteTodo";
  static String todoList = "todo/todoList";
}
