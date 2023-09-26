import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/foto_model.dart';

class RectNilaiModel extends Equatable {
  final String id;
  final String rectId;
  final String pmId;
  final String loadr;
  final String loads;
  final String loadt;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel> foto;

  const RectNilaiModel(
      {required this.id,
      required this.rectId,
      required this.pmId,
      required this.loadr,
      required this.loads,
      required this.loadt,
      required this.temuan,
      required this.rekomendasi,
      required this.createdAt,
      required this.updatedAt,
      required this.foto});

  factory RectNilaiModel.fromJson(Map<String, dynamic> json) {
    return RectNilaiModel(
      id: json['id'].toString(),
      rectId: json['rect_id'].toString(),
      pmId: json['pm_id'].toString(),
      loadr: (json['loadr'] ?? 0.0).toString(),
      loads: (json['loads'] ?? 0.0).toString(),
      loadt: (json['loadt'] ?? 0.0).toString(),
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
  List<Object?> get props => [
        id,
        rectId,
        pmId,
        loadr,
        loads,
        loadt,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
        foto
      ];
}
