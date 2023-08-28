import 'package:equatable/equatable.dart';

class AcMasterModel extends Equatable {
  final int id;
  final int popId;
  final String merk;
  final String kapasitas;
  final String nama;
  final String kondisi;
  final String tekananFreon;
  final String modeHidup;
  // final DateTime tanggalInstalasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AcMasterModel({
    required this.id,
    required this.popId,
    required this.kapasitas,
    required this.tekananFreon,
    required this.merk,
    required this.nama,
    required this.modeHidup,
    required this.kondisi,
    // required this.tanggalInstalasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcMasterModel.fromJson(Map<String, dynamic> json) {
    return AcMasterModel(
      id: int.parse(json['id'].toString()),
      popId: int.parse(json['pop_id'].toString()),
      kapasitas: json['kapasitas'],
      tekananFreon: json['tekanan_freon'],
      merk: json['merk'],
      nama: json['nama'],
      modeHidup: json['mode_hidup'],
      kondisi: json['kondisi'],
      // tanggalInstalasi: DateTime.parse(json['tgl_instalasi']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        kapasitas,
        tekananFreon,
        merk,
        nama,
        modeHidup,
        kondisi,
        // tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
