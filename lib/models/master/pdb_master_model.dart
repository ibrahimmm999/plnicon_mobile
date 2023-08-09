import 'package:equatable/equatable.dart';

class PdbMasterModel extends Equatable {
  final int id;
  final int popId;
  final String nama;
  final String tipe;
  final String arester;
  final String aresterTipe;
  final DateTime tanggalInstalasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PdbMasterModel({
    required this.id,
    required this.popId,
    required this.nama,
    required this.arester,
    required this.aresterTipe,
    required this.tipe,
    required this.createdAt,
    required this.tanggalInstalasi,
    required this.updatedAt,
  });

  factory PdbMasterModel.fromJson(Map<String, dynamic> json) {
    return PdbMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      nama: json['nama'],
      arester: json['arester'],
      tipe: json['tipe'],
      aresterTipe: json['arester_tipe'],
      tanggalInstalasi: DateTime.parse(json['tgl_instalasi']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        nama,
        tipe,
        aresterTipe,
        arester,
        tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
