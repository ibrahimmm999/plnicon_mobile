import 'package:equatable/equatable.dart';

class RackMasterModel extends Equatable {
  final int id;
  final int popId;
  final int nomorRack;
  final String lokasi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RackMasterModel({
    required this.id,
    required this.popId,
    required this.nomorRack,
    required this.lokasi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RackMasterModel.fromJson(Map<String, dynamic> json) {
    return RackMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      nomorRack: json['nomor_rack'],
      lokasi: json['lokasi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        nomorRack,
        lokasi,
        createdAt,
        updatedAt,
      ];
}
