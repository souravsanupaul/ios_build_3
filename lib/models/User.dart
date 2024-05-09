import 'package:hive/hive.dart';
part 'User.g.dart'; // Generated file

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? email;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? password;

  @HiveField(4)
  String? phone;

  @HiveField(5)
  String? accountId;

  @HiveField(6)
  String? lastLogin;

  @HiveField(7)
  String? userToken;

  User({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.phone,
    this.accountId,
    this.lastLogin,
    this.userToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      accountId: json['account_id'] ?? '',
      lastLogin: json['last_login'] ?? '',
      userToken: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'phone': phone,
      'account_id': accountId,
      'last_login': lastLogin,
      'token': userToken,
    };
  }
}
