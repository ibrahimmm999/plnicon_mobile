import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String nama;
  final String email;
  final String username;
  final String phone;
  final String role;
  final String photoUrl;
  final String token;

  const UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.username,
    required this.phone,
    required this.role,
    required this.photoUrl,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      photoUrl: json['profile_photo_url'],
      role: json['role'],
      token: token,
    );
  }

  @override
  List<Object?> get props =>
      [id, nama, email, username, phone, role, photoUrl, token];
}
