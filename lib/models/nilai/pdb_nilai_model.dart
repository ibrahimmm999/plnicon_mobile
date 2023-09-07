import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/foto_model.dart';

class PdbNilaiModel extends Equatable {
  final int id;
  final int pdbId;
  final int pmId;
  final String aresterWarna;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel> foto;

  const PdbNilaiModel(
      {required this.id,
      required this.pdbId,
      required this.pmId,
      required this.aresterWarna,
      required this.temuan,
      required this.rekomendasi,
      required this.createdAt,
      required this.updatedAt,
      required this.foto});

  factory PdbNilaiModel.fromJson(Map<String, dynamic> json) {
    return PdbNilaiModel(
      id: json['id'],
      pdbId: json['pdb_id'],
      pmId: json['pm_id'],
      aresterWarna: json['arester_warna'],
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
        pdbId,
        pmId,
        aresterWarna,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
        foto
      ];
}
