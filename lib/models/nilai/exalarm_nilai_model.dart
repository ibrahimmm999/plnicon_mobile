import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/foto_model.dart';

class ExAlarmNilaiModel extends Equatable {
  final int id;
  final int plnOff;
  final int pmId;
  final String suhu;
  final String ea;
  final String pintu;
  final String gensetRunFail;
  final String smokeAndFire;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel>? foto;

  const ExAlarmNilaiModel({
    required this.id,
    required this.plnOff,
    required this.pmId,
    required this.suhu,
    required this.ea,
    required this.pintu,
    required this.smokeAndFire,
    required this.gensetRunFail,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
    required this.foto,
  });

  factory ExAlarmNilaiModel.fromJson(Map<String, dynamic> json) {
    return ExAlarmNilaiModel(
      id: json['id'],
      plnOff: json['pln_off'],
      pmId: json['pm_id'],
      suhu: json['suhu'],
      ea: json['ea'],
      smokeAndFire: json['smokenfire'],
      gensetRunFail: json['genset_run_fail'],
      pintu: json['pintu'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
      foto: json['foto'] != null
          ? List<FotoModel>.from(
              json['foto'].map((x) => FotoModel.fromJson(x)),
            )
          : [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        plnOff,
        pmId,
        suhu,
        ea,
        pintu,
        temuan,
        gensetRunFail,
        smokeAndFire,
        rekomendasi,
        createdAt,
        updatedAt,
        foto,
      ];
}
