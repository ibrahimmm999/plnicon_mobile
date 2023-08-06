import 'package:equatable/equatable.dart';

class KwhNilaiModel extends Equatable {
  final int id;
  final int kwhId;
  final int pmId;
  final double loadR;
  final double loadS;
  final double loadT;
  final double vrn;
  final double vsn;
  final double vtn;
  final double vng;
  final double vrs;
  final double vrt;
  final double vst;
  final double temuan;
  final double rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const KwhNilaiModel({
    required this.id,
    required this.kwhId,
    required this.pmId,
    required this.loadR,
    required this.loadS,
    required this.loadT,
    required this.vrn,
    required this.vsn,
    required this.vtn,
    required this.vng,
    required this.vrs,
    required this.vrt,
    required this.vst,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KwhNilaiModel.fromJson(Map<String, dynamic> json) {
    return KwhNilaiModel(
      id: json['id'],
      kwhId: json['kwh_id'],
      pmId: json['pm_id'],
      loadR: json['load_r'],
      loadS: json['load_s'],
      loadT: json['load_t'],
      vrn: json['vrn'],
      vsn: json['vsn'],
      vtn: json['vtn'],
      vng: json['vng'],
      vrs: json['vrs'],
      vrt: json['vrt'],
      vst: json['vst'],
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        kwhId,
        pmId,
        loadR,
        loadS,
        loadT,
        vrn,
        vsn,
        vtn,
        vng,
        vrs,
        vrt,
        vst,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
      ];
}
