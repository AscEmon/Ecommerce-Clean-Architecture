class LoginResponse {
  String? accessToken;
  String? refreshToken;
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;

  LoginResponse({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json['accessToken'],
    refreshToken: json['refreshToken'],
    id: json['id'],
    username: json['username'],
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    gender: json['gender'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'image': image,
  };
}
