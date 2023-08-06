import 'package:equatable/equatable.dart';

class PdbNilaiModel extends Equatable {
  final int id;
  final int pdbId;
  final int pmId;
  final String aresterWarna;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PdbNilaiModel({
    required this.id,
    required this.pdbId,
    required this.pmId,
    required this.aresterWarna,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
  });

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
      ];
}
