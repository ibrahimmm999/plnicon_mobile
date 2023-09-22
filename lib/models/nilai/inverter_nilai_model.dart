import 'package:equatable/equatable.dart';

import '../foto_model.dart';

class InverterNilaiModel extends Equatable {
  final int id;
  final int inverterId;
  final int pmId;
  final String load;
  final String inputAc;
  final String inputDc;
  final String ouputDc;
  final String mainfall;
  final String hasilUji;
  final String temuan;
  final String rekomendasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final List<FotoModel> foto;

  const InverterNilaiModel({
    required this.id,
    required this.inverterId,
    required this.pmId,
    required this.load,
    required this.inputAc,
    required this.inputDc,
    required this.ouputDc,
    required this.mainfall,
    required this.hasilUji,
    required this.temuan,
    required this.rekomendasi,
    required this.createdAt,
    required this.updatedAt,
    // required this.foto,
  });

  factory InverterNilaiModel.fromJson(Map<String, dynamic> json) {
    return InverterNilaiModel(
      id: json['id'],
      inverterId: json['inverter_id'],
      pmId: json['pm_id'],
      load: json['load'],
      inputAc: json['input_ac'],
      inputDc: json['input_dc'],
      ouputDc: json['output_dc'],
      mainfall: json['mainfall'],
      hasilUji: json['hasil_uji'],
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
        inverterId,
        pmId,
        load,
        inputAc,
        inputDc,
        ouputDc,
        mainfall,
        hasilUji,
        temuan,
        rekomendasi,
        createdAt,
        updatedAt,
        // foto,
      ];
}
