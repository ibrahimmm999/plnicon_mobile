import 'package:equatable/equatable.dart';

class EnvironmentModel extends Equatable {
  final int id;
  final int popId;
  final int pmId;
  final String exhaust;
  final String kebersihanExhaust;
  final String lampu;
  final String jumlahLampu;
  final double suhuRuangan;
  final String bangunan;
  final String kebersihanBangunan;
  final DateTime tglInstalasi;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EnvironmentModel({
    required this.id,
    required this.popId,
    required this.pmId,
    required this.exhaust,
    required this.kebersihanExhaust,
    required this.lampu,
    required this.jumlahLampu,
    required this.suhuRuangan,
    required this.bangunan,
    required this.kebersihanBangunan,
    required this.tglInstalasi,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EnvironmentModel.fromJson(Map<String, dynamic> json) {
    return EnvironmentModel(
      id: json['id'],
      popId: json['pop_id'],
      pmId: json['pm_id'],
      exhaust: json['exhaust'],
      kebersihanExhaust: json['kebersihan_exhaust'],
      lampu: json['lampu'],
      jumlahLampu: json['jumlah_lampu'],
      suhuRuangan: json['suhu_ruangan'],
      bangunan: json['bangunan'],
      kebersihanBangunan: json['kebersihan_bangunan'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
      tglInstalasi: DateTime.parse(json['tgl_instalasi']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        pmId,
        exhaust,
        kebersihanExhaust,
        lampu,
        jumlahLampu,
        suhuRuangan,
        bangunan,
        kebersihanBangunan,
        tglInstalasi,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
      ];
}
