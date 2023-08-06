import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/foto_model.dart';

class AcNilaiModel extends Equatable {
  final int id;
  final int acId;
  final int pmId;
  final int suhuAc;
  final String hasilPengujian;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel> foto;

  const AcNilaiModel({
    required this.id,
    required this.acId,
    required this.pmId,
    required this.suhuAc,
    required this.hasilPengujian,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
    required this.foto,
  });

  factory AcNilaiModel.fromJson(Map<String, dynamic> json) {
    return AcNilaiModel(
      id: json['id'],
      acId: json['ac_id'],
      pmId: json['pm_id'],
      suhuAc: json['suhu_ac'],
      hasilPengujian: json['hasil_pengujian'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
      foto: List<FotoModel>.from(
        json['foto'].map((x) => FotoModel.fromJson(x)),
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        acId,
        pmId,
        suhuAc,
        hasilPengujian,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
        foto,
      ];
}
