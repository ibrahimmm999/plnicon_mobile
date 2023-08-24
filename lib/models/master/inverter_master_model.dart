import 'package:equatable/equatable.dart';

class InverterMasterModel extends Equatable {
  final int id;
  final int popId;
  final int kapasitas;
  final String kondisi;
  final String merk;
  final String sn;
  final String tipe;
  // final DateTime tanggalInstalasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InverterMasterModel({
    required this.id,
    required this.popId,
    required this.kapasitas,
    required this.kondisi,
    required this.merk,
    required this.sn,
    required this.tipe,
    // required this.tanggalInstalasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InverterMasterModel.fromJson(Map<String, dynamic> json) {
    return InverterMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      kapasitas: json['kapasitas'],
      kondisi: json['kondisi'],
      merk: json['merk'],
      sn: json['sn'],
      tipe: json['tipe'],
      // tanggalInstalasi: json['tgl_instalasi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        kapasitas,
        kondisi,
        merk,
        sn,
        tipe,
        // tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
