import 'package:equatable/equatable.dart';

/// Profile entity - Represents profile in the business domain
class Profile extends Equatable {
  final int id;
  final String fullName;

  final String email;
  final String phone;

  const Profile({
    required this.id,
    required this.fullName,

    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, fullName, email, phone];
}
