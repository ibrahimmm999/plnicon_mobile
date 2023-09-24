import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/foto_model.dart';

class KwhNilaiModel extends Equatable {
  final String id;
  final String kwhId;
  final String pmId;
  final String loadPhasaR;
  final String loadPhasaS;
  final String loadPhasaT;
  final String vrn;
  final String vsn;
  final String vtn;
  final String vrs;
  final String vrt;
  final String vst;
  final String vng;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FotoModel> foto;

  const KwhNilaiModel(
      {required this.id,
      required this.kwhId,
      required this.pmId,
      required this.loadPhasaR,
      required this.loadPhasaS,
      required this.loadPhasaT,
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
      required this.foto});

  factory KwhNilaiModel.fromJson(Map<String, dynamic> json) {
    return KwhNilaiModel(
      id: json['id'].toString(),
      kwhId: json['kwh_id'].toString(),
      pmId: json['pm_id'].toString(),
      vrn: (json['vrn'] ?? 0).toString(),
      vtn: (json['vtn'] ?? 0).toString(),
      vsn: (json['vsn'] ?? 0).toString(),
      vng: (json['vng'] ?? 0).toString(),
      vrs: (json['vrs'] ?? 0).toString(),
      vrt: (json['vrt'] ?? 0).toString(),
      vst: (json['vst'] ?? 0).toString(),
      loadPhasaR: (json['load_r'] ?? 0).toString(),
      loadPhasaS: (json['load_s'] ?? 0).toString(),
      loadPhasaT: (json['load_t'] ?? 0).toString(),
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
        kwhId,
        pmId,
        loadPhasaR,
        loadPhasaS,
        loadPhasaT,
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
        foto
      ];
}
