import 'package:equatable/equatable.dart';

class BateraiMasterModel extends Equatable {
  final int id;
  final int rectId;
  final int bankId;
  final String nama;
  final String merk;
  final String tipe;
  final String sn;
  final int kapasitas;
  final double persentase;
  final double vBatt;
  final String tanggalInstalasi;
  final String tanggalUji;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BateraiMasterModel({
    required this.id,
    required this.rectId,
    required this.kapasitas,
    required this.bankId,
    required this.nama,
    required this.persentase,
    required this.merk,
    required this.sn,
    required this.tipe,
    required this.vBatt,
    required this.tanggalInstalasi,
    required this.tanggalUji,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BateraiMasterModel.fromJson(Map<String, dynamic> json) {
    return BateraiMasterModel(
      id: json['id'],
      rectId: json['rect_id'],
      bankId: json['bank_id'],
      kapasitas: json['kapasitas'],
      nama: json['nama'],
      persentase: double.parse(json['persentase'].toString()),
      merk: json['merk'],
      sn: json['sn'],
      tipe: json['tipe'],
      vBatt: double.parse(json['vbatt'].toString()),
      tanggalInstalasi: json['tgl_instalasi'],
      tanggalUji: json['tgl_uji'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        rectId,
        kapasitas,
        bankId,
        persentase,
        nama,
        merk,
        sn,
        tipe,
        vBatt,
        tanggalInstalasi,
        tanggalUji,
        createdAt,
        updatedAt,
      ];
}
