import 'package:equatable/equatable.dart';

import '../foto_model.dart';

class GensetNilaiModel extends Equatable {
  final int id;
  final int gensetId;
  final int pmId;
  final int fuel;
  final double hourMeter;
  final double teganganAccu;
  final double teganganCharger;
  final double arusCharger;
  final String failOverTest;
  final double tempOn;
  final double ujiBebanVolt;
  final double ujiBebanArus;
  final double ujiTanpaBebanVolt;
  final double ujiTanpaBebanArus;
  final String indoorClean;
  final String outdoorClean;
  final String temuan;
  final String rekomendasi;
  final String kartuGantungUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel>? foto;

  const GensetNilaiModel({
    required this.id,
    required this.gensetId,
    required this.pmId,
    required this.fuel,
    required this.hourMeter,
    required this.teganganAccu,
    required this.teganganCharger,
    required this.arusCharger,
    required this.failOverTest,
    required this.tempOn,
    required this.ujiBebanVolt,
    required this.ujiBebanArus,
    required this.ujiTanpaBebanVolt,
    required this.ujiTanpaBebanArus,
    required this.indoorClean,
    required this.outdoorClean,
    required this.temuan,
    required this.rekomendasi,
    required this.kartuGantungUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.foto,
  });

  factory GensetNilaiModel.fromJson(Map<String, dynamic> json) {
    return GensetNilaiModel(
      id: json['id'],
      gensetId: json['genset_id'],
      pmId: json['pm_id'],
      fuel: json['fuel'],
      hourMeter: double.parse(json['hour_meter'].toString()),
      teganganAccu: double.parse(json['tegangan_accu'].toString()),
      teganganCharger: double.parse(json['tegangan_charger'].toString()),
      arusCharger: double.parse(json['arus_charger'].toString()),
      failOverTest: json['fail_over_test'],
      tempOn: double.parse(json['temp_on'].toString()),
      ujiBebanVolt: double.parse(json['uji_beban_volt'].toString()),
      ujiBebanArus: double.parse(json['uji_beban_arus'].toString()),
      ujiTanpaBebanVolt: double.parse(json['uji_tanpa_beban_volt'].toString()),
      ujiTanpaBebanArus: double.parse(json['uji_tanpa_beban_arus'].toString()),
      indoorClean: json['indoor_clean'],
      outdoorClean: json['outdoor_clean'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      kartuGantungUrl: json['kartu_gantung_url'] ?? "",
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
        gensetId,
        pmId,
        fuel,
        hourMeter,
        teganganAccu,
        teganganCharger,
        arusCharger,
        failOverTest,
        tempOn,
        ujiBebanVolt,
        ujiBebanArus,
        ujiTanpaBebanVolt,
        ujiTanpaBebanArus,
        indoorClean,
        outdoorClean,
        temuan,
        rekomendasi,
        kartuGantungUrl,
        createdAt,
        updatedAt,
        foto,
      ];
}
