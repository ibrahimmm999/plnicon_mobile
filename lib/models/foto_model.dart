import 'package:equatable/equatable.dart';

class FotoModel extends Equatable {
  final int id;
  final String url;
  final String deskripsi;

  const FotoModel({
    required this.id,
    required this.url,
    required this.deskripsi,
  });

  factory FotoModel.fromJson(Map<String, dynamic> json) {
    return FotoModel(
      id: json['id'],
      url: json['url'],
      deskripsi: json['deskripsi'] ?? "",
    );
  }

  @override
  List<Object?> get props => [id, url, deskripsi];
}
