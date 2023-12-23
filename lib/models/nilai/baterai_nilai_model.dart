import 'package:equatable/equatable.dart';

import '../foto_model.dart';

class BateraiNilaiModel extends Equatable {
  final int id;
  final int bateraiId;
  final int pmId;
  final double load;
  final double groupVbank;
  final int timeDischarge;
  final int stopUjiBaterai;
  final double performance;
  final double sisaKapasitas;
  final double kemampuanBackupTime;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel>? foto;

  const BateraiNilaiModel({
    required this.id,
    required this.bateraiId,
    required this.pmId,
    required this.load,
    required this.groupVbank,
    required this.timeDischarge,
    required this.stopUjiBaterai,
    required this.performance,
    required this.sisaKapasitas,
    required this.kemampuanBackupTime,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
    required this.foto,
  });

  factory BateraiNilaiModel.fromJson(Map<String, dynamic> json) {
    return BateraiNilaiModel(
      id: json['id'],
      bateraiId: json['baterai_id'],
      pmId: json['pm_id'],
      load: json['load'],
      groupVbank: json['group_vbank'],
      timeDischarge: json['time_discharge'],
      stopUjiBaterai: json['stop_uji_baterai'],
      performance: json['performance'],
      sisaKapasitas: json['sisa_kapasitas'],
      kemampuanBackupTime: json['kemampuan_backup_time'],
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
        bateraiId,
        pmId,
        load,
        groupVbank,
        timeDischarge,
        stopUjiBaterai,
        performance,
        sisaKapasitas,
        kemampuanBackupTime,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
        foto,
      ];
}
