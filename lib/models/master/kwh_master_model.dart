import 'package:equatable/equatable.dart';

class KwhMasterModel extends Equatable {
  final int id;
  final int popId;
  final int jumlahPhasa;
  final double daya;
  final double capmcbr;
  final double capmcbs;
  final double capmcbt;
  final double luasKabelR;
  final double luasKabelS;
  final double luasKabelT;
  final double luasKabelN;
  final String cos;
  final String arester;
  final String aresterType;
  // final String warnaKabelR;
  // final String warnaKabelS;
  // final String warnaKabelT;
  // final String warnaKabelN;
  // final String warnaKabelG;
  final String cosType;
  // final DateTime tanggalInstalasi;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  const KwhMasterModel({
    required this.id,
    required this.popId,
    required this.daya,
    required this.cos,
    required this.jumlahPhasa,
    required this.capmcbr,
    required this.capmcbt,
    required this.capmcbs,
    required this.cosType,
    required this.arester,
    required this.aresterType,
    required this.luasKabelN,
    required this.luasKabelT,
    required this.luasKabelS,
    required this.luasKabelR,
    // required this.warnaKabelG,
    // required this.warnaKabelT,
    // required this.warnaKabelS,
    // required this.warnaKabelN,
    // required this.warnaKabelR,
    // required this.tanggalInstalasi,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory KwhMasterModel.fromJson(Map<String, dynamic> json) {
    return KwhMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      daya: json['daya'],
      cos: json['cos'],
      jumlahPhasa: json['jumlah_phasa'],
      capmcbr: json['capmcbr'] ?? "",
      cosType: json['cos_type'] ?? "",
      capmcbs: json['capmcbs'] ?? "",
      arester: json['arester'],
      capmcbt: json['capmcbt'] ?? "",
      aresterType: json['arester_type'] ?? "",
      luasKabelN: json['luas_kabeln'] ?? "",
      luasKabelS: json['luas_kabels'] ?? "",
      luasKabelT: json['luas_kabelt'] ?? "",
      luasKabelR: json['luas_kabelr'] ?? "",
      // warnaKabelG: json['warna_kabelg'] ?? "",
      // warnaKabelN: json['warna_kabeln'] ?? "",
      // warnaKabelS: json['warna_kabels'] ?? "",
      // warnaKabelR: json['warna_kabelr'] ?? "",
      // warnaKabelT: json['warna_kabelt'] ?? "",
      // tanggalInstalasi: DateTime.parse(json['tgl_instalasi']),
      // createdAt: DateTime.parse(json['created_at']),
      // updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        daya,
        cos,
        jumlahPhasa,
        capmcbr,
        cosType,
        arester,
        aresterType,
        luasKabelN,
        luasKabelR,
        luasKabelT,
        luasKabelS,
        // warnaKabelG,
        // warnaKabelN,
        // warnaKabelR,
        // warnaKabelS,
        // warnaKabelT,
        capmcbs,
        capmcbt,
        // tanggalInstalasi,
        // createdAt,
        // updatedAt,
      ];
}
