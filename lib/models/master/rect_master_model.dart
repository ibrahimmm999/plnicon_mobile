import 'package:equatable/equatable.dart';

class RectMasterModel extends Equatable {
  final int id;
  final int popId;
  final String merk;
  final String tipe;
  final int jumlahPhasa;
  final String sn;
  final int slotModul;
  final int modulTerpasang;
  final int modulControl;
  final DateTime tanggalInstalasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RectMasterModel({
    required this.id,
    required this.popId,
    required this.jumlahPhasa,
    required this.slotModul,
    required this.modulTerpasang,
    required this.modulControl,
    required this.merk,
    required this.sn,
    required this.tipe,
    required this.tanggalInstalasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RectMasterModel.fromJson(Map<String, dynamic> json) {
    return RectMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      jumlahPhasa: json['jumlah_phasa'],
      slotModul: json['slot_modul'],
      modulTerpasang: json['modul_terpasang'],
      modulControl: json['modul_control'],
      merk: json['merk'],
      sn: json['sn'],
      tipe: json['tipe'],
      tanggalInstalasi: json['tgl_instalasi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        jumlahPhasa,
        slotModul,
        modulControl,
        modulTerpasang,
        merk,
        sn,
        tipe,
        tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
