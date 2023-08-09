import 'package:equatable/equatable.dart';

class McbMasterModel extends Equatable {
  final int id;
  final int pdbId;
  final String nama;
  final String merk;
  final String phasa;
  final String tipe;
  final String peruntukan;
  final int kapasitas;
  final int aTerukur;
  final DateTime tanggalInstalasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const McbMasterModel({
    required this.id,
    required this.pdbId,
    required this.nama,
    required this.kapasitas,
    required this.merk,
    required this.tipe,
    required this.phasa,
    required this.peruntukan,
    required this.aTerukur,
    required this.createdAt,
    required this.tanggalInstalasi,
    required this.updatedAt,
  });

  factory McbMasterModel.fromJson(Map<String, dynamic> json) {
    return McbMasterModel(
      id: json['id'],
      pdbId: json['pdb_id'],
      nama: json['nama'],
      kapasitas: json['kapasitas'],
      phasa: json['phasa'],
      merk: json['merk'],
      tipe: json['tipe'],
      peruntukan: json['peruntukan'],
      aTerukur: json['a_terukur'],
      tanggalInstalasi: DateTime.parse(json['tgl_instalasi']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        pdbId,
        nama,
        phasa,
        merk,
        kapasitas,
        aTerukur,
        tipe,
        peruntukan,
        tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
