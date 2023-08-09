import 'package:equatable/equatable.dart';

class PerangkatMasterModel extends Equatable {
  final int id;
  final int rackId;
  final String nama;
  final String merk;
  final String sumberMain;
  final String sumberBackup;
  final String terminasi;
  final String jenis;
  final String tipe;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PerangkatMasterModel({
    required this.id,
    required this.rackId,
    required this.nama,
    required this.merk,
    required this.sumberMain,
    required this.sumberBackup,
    required this.terminasi,
    required this.jenis,
    required this.tipe,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PerangkatMasterModel.fromJson(Map<String, dynamic> json) {
    return PerangkatMasterModel(
      id: json['id'],
      rackId: json['rack_id'],
      nama: json['nama'],
      merk: json['merk'],
      jenis: json['jenis'],
      tipe: json['tipe'],
      sumberBackup: json['sumber_backup'],
      sumberMain: json['sumber_main'],
      terminasi: json['terminasi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        rackId,
        nama,
        jenis,
        tipe,
        sumberBackup,
        sumberMain,
        terminasi,
        merk,
        createdAt,
        updatedAt,
      ];
}
