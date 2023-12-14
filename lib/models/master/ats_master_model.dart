import 'package:equatable/equatable.dart';

class AtsMasterModel extends Equatable {
  final int id;
  final int popId;
  final String merk;
  final String tipe;
  final String sn;
  final String status;
  final String tanggalInstalasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AtsMasterModel({
    required this.id,
    required this.popId,
    required this.tipe,
    required this.merk,
    required this.sn,
    required this.status,
    required this.tanggalInstalasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AtsMasterModel.fromJson(Map<String, dynamic> json) {
    return AtsMasterModel(
      id: int.parse(json['id'].toString()),
      popId: int.parse(json['pop_id'].toString()),
      tipe: json['tipe'],
      status: json['status'],
      sn: json['sn'],
      merk: json['merk'],
      tanggalInstalasi: json['tgl_instalasi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        tipe,
        merk,
        sn,
        status,
        tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
