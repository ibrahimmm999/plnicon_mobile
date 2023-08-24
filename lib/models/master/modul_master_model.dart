import 'package:equatable/equatable.dart';

class ModulMasterModel extends Equatable {
  final int id;
  final int rectId;
  final int kapasitas;
  final String sn;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ModulMasterModel({
    required this.id,
    required this.rectId,
    required this.kapasitas,
    required this.sn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ModulMasterModel.fromJson(Map<String, dynamic> json) {
    return ModulMasterModel(
      id: json['id'],
      rectId: json['rect_id'],
      kapasitas: int.parse(json['kapasitas'].toString()),
      sn: json['sn'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        rectId,
        kapasitas,
        sn,
        createdAt,
        updatedAt,
      ];
}
