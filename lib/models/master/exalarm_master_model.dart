import 'package:equatable/equatable.dart';

class ExAlarmMasterModel extends Equatable {
  final int id;
  final int popId;
  final int perangkatEa;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime tanggalInstalasi;

  const ExAlarmMasterModel(
      {required this.id,
      required this.popId,
      required this.perangkatEa,
      required this.createdAt,
      required this.updatedAt,
      required this.tanggalInstalasi});

  factory ExAlarmMasterModel.fromJson(Map<String, dynamic> json) {
    return ExAlarmMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      perangkatEa: json['perangkat_ea'],
      tanggalInstalasi: DateTime.parse(json['tgl_instalasi']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popId,
        perangkatEa,
        tanggalInstalasi,
        createdAt,
        updatedAt,
      ];
}
