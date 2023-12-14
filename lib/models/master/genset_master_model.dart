import 'package:equatable/equatable.dart';

class GensetMasterModel extends Equatable {
  final int id;
  final int popId;
  final String merk;
  final int kapasitas;
  final String sn;
  final int maxFuel;
  final String merkEngine;
  final String merkGen;
  final String bahanBakar;
  final String merkAccu;
  final String switchGenset;
  final double accu;
  final String tipeBattCharger;
  final String tanggalInstalasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GensetMasterModel({
    required this.id,
    required this.popId,
    required this.kapasitas,
    required this.maxFuel,
    required this.merkEngine,
    required this.bahanBakar,
    required this.merk,
    required this.sn,
    required this.merkGen,
    required this.accu,
    required this.merkAccu,
    required this.switchGenset,
    required this.tipeBattCharger,
    required this.tanggalInstalasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GensetMasterModel.fromJson(Map<String, dynamic> json) {
    return GensetMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      maxFuel: json['max_fuel'],
      kapasitas: json['kapasitas'],
      merkEngine: json['merk_engine'],
      bahanBakar: json['bahan_bakar'],
      merk: json['merk'],
      sn: json['sn'],
      merkGen: json['merk_gen'],
      switchGenset: json['switch'],
      tipeBattCharger: json['tipe_batt_charger'],
      accu: double.parse(json['accu'].toString()),
      merkAccu: json['merk_accu'],
      tanggalInstalasi: (json['tgl_instalasi']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        kapasitas,
        maxFuel,
        bahanBakar,
        merkEngine,
        merk,
        sn,
        merkGen,
        accu,
        switchGenset,
        merkAccu,
        tipeBattCharger,
        tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
