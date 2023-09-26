import 'package:equatable/equatable.dart';

import '../foto_model.dart';

class BateraiNilaiModel extends Equatable {
  final int id;
  final int bateraiId;
  final int pmId;
  final double load;
  final double groupVbank;
  final double cellV1;
  final double cellV2;
  final double cellV3;
  final double cellV4;
  final int timeDischarge;
  final int stopUjiBaterai;
  final double performance;
  final double sisaKapasitas;
  final double kemampuanBackupTime;
  final int jumlahBateraiRusak;
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
    required this.cellV1,
    required this.cellV2,
    required this.cellV3,
    required this.cellV4,
    required this.timeDischarge,
    required this.stopUjiBaterai,
    required this.performance,
    required this.sisaKapasitas,
    required this.kemampuanBackupTime,
    required this.jumlahBateraiRusak,
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
      cellV1: json['cell_v1'],
      cellV2: json['cell_v2'],
      cellV3: json['cell_v3'],
      cellV4: json['cell_v4'],
      timeDischarge: json['time_discharge'],
      stopUjiBaterai: json['stop_uji_baterai'],
      performance: json['performance'],
      sisaKapasitas: json['sisa_kapasitas'],
      kemampuanBackupTime: json['kemampuan_backup_time'],
      jumlahBateraiRusak: json['jumlah_baterai_rusak'],
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
        cellV1,
        cellV2,
        cellV3,
        cellV4,
        timeDischarge,
        stopUjiBaterai,
        performance,
        sisaKapasitas,
        kemampuanBackupTime,
        jumlahBateraiRusak,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
        foto,
      ];
}
