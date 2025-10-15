import 'package:equatable/equatable.dart';

/// Profile entity - Represents profile in the business domain
class Profile extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String phone;

  const Profile({
    this.id = 0,
    this.fullName = '',
    this.email = '',
    this.phone = '',
  });

  @override
  List<Object?> get props => [id, fullName, email, phone];
}
