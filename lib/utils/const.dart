class Const {
  Const._();

  static const String name = 'name';
  static const String username = 'username';
  static const String password = 'password';
  static const String confirmPassword = 'confirm_password';
  static const String baseUrl = "http://localhost:8080/api";
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 15000;
  static const String token = 'token';
}

class Endpoints {
  Endpoints._();

  static const String register = '/auth/register';
  static const String login = '/auth/login';
}
