import 'package:hive/hive.dart';

part 'mod_usuario.g.dart';

@HiveType(typeId: 1)
class Usuario {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
