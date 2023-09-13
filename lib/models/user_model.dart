class UserModel {
  String id;
  String name;
  String email;
  int age;

  UserModel(
      {this.id = '',
      required this.name,
      required this.email,
      required this.age});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name'],
            age: json['age'],
            email: json['email']);

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "age": age,
    };
  }
}
