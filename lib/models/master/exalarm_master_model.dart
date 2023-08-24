import 'package:equatable/equatable.dart';

class ExAlarmMasterModel extends Equatable {
  final int id;
  final int popId;
  final int pmId;
  final int perangkatEa;
  final String ea;
  final String suhu;
  final String pintu;
  final int plnOff;
  final String gensetRunFail;
  final String smokeAndFire;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final DateTime tanggalInstalasi;

  const ExAlarmMasterModel({
    required this.id,
    required this.popId,
    required this.perangkatEa,
    required this.createdAt,
    required this.updatedAt,
    required this.pmId,
    required this.suhu,
    required this.ea,
    required this.pintu,
    required this.smokeAndFire,
    required this.gensetRunFail,
    required this.temuan,
    required this.plnOff,
    required this.rekomendasi,
    // required this.tanggalInstalasi
  });

  factory ExAlarmMasterModel.fromJson(Map<String, dynamic> json) {
    return ExAlarmMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      perangkatEa: int.parse(json['perangkat_ea'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
      pmId: json['pm_id'],
      suhu: json['suhu'],
      ea: json['ea'],
      plnOff: int.parse(json['pln_off'].toString()),
      smokeAndFire: json['smokenfire'],
      gensetRunFail: json['genset_run_fail'],
      pintu: json['pintu'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      // tanggalInstalasi: DateTime.parse(json['tgl_instalasi']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        perangkatEa,
        // tanggalInstalasi,
        createdAt,
        updatedAt,
        pmId,
        suhu,
        ea,
        plnOff,
        smokeAndFire,
        gensetRunFail,
        pintu,
        temuan,
        rekomendasi
      ];
}
