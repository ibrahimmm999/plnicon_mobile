import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/foto_model.dart';

class PerangkatNilaiModel extends Equatable {
  final int id;
  final int pmId;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel>? foto;

  const PerangkatNilaiModel(
      {required this.id,
      required this.pmId,
      required this.temuan,
      required this.rekomendasi,
      required this.createdAt,
      required this.updatedAt,
      required this.foto});

  factory PerangkatNilaiModel.fromJson(Map<String, dynamic> json) {
    return PerangkatNilaiModel(
      id: json['id'],
      pmId: json['pm_id'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
      foto: json['foto'] != null
          ? List<FotoModel>.from(
              json['foto'].map((x) => FotoModel.fromJson(x)),
            )
          : [],
    );
  }

  @override
  List<Object?> get props =>
      [id, pmId, temuan, rekomendasi, createdAt, updatedAt, foto];
}
