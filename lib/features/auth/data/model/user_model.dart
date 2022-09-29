
class UserModel {
  final String? name, email, phone, uId;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
    name: json?['name'],
    email: json?['email'],
    phone: json?['phone'],
    uId: json?['uId'],

  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'uId': uId,
  };
}
