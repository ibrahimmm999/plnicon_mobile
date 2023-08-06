import 'package:equatable/equatable.dart';

class PerangkatNilaiModel extends Equatable {
  final int id;
  final int pmId;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PerangkatNilaiModel({
    required this.id,
    required this.pmId,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PerangkatNilaiModel.fromJson(Map<String, dynamic> json) {
    return PerangkatNilaiModel(
      id: json['id'],
      pmId: json['pm_id'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        pmId,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
      ];
}
