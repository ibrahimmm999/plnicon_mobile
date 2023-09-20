import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/foto_model.dart';

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
  // final List<FotoModel> foto;

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
    // required this.foto
  });

  factory KwhNilaiModel.fromJson(Map<String, dynamic> json) {
    return KwhNilaiModel(
      id: json['id'],
      kwhId: json['kwh_id'],
      pmId: json['pm_id'],
      vrn: double.parse(json['vrn']),
      vsn: double.parse(json['vsn']),
      vtn: double.parse(json['vtn']),
      vng: double.parse(json['vng']),
      vrs: double.parse(json['vrs']),
      vrt: double.parse(json['vrt']),
      vst: double.parse(json['vst']),
      loadR: double.parse(json['load_r']),
      loadS: double.parse(json['load_s']),
      loadT: double.parse(json['load_t']),
      temuan: json['temuan'] ?? "",
      rekomendasi: json['rekomendasi'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
      // foto: List<FotoModel>.from(
      //   json['foto'].map((x) => FotoModel.fromJson(x)),
      // ),
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
        // foto
      ];
}
