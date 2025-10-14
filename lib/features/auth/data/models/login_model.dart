import '/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.username, required super.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
