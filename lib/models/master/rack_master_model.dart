import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/master/perangkat_master_model.dart';

class RackMasterModel extends Equatable {
  final int id;
  final int popId;
  final int nomorRack;
  final String lokasi;
  final String? tglInstalasi;
  final List<PerangkatMasterModel> listPerangkat;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RackMasterModel({
    required this.id,
    required this.popId,
    required this.nomorRack,
    required this.lokasi,
    required this.listPerangkat,
    required this.createdAt,
    required this.updatedAt,
    this.tglInstalasi,
  });

  factory RackMasterModel.fromJson(Map<String, dynamic> json) {
    return RackMasterModel(
      id: json['id'],
      popId: json['pop_id'],
      nomorRack: json['nomor_rack'],
      lokasi: json['lokasi'],
      tglInstalasi: json['tgl_instalasi'],
      listPerangkat: json['perangkat'] == null
          ? []
          : List<PerangkatMasterModel>.from(
              json['perangkat'].map((x) => PerangkatMasterModel.fromJson(x))),
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
        listPerangkat,
        createdAt,
        updatedAt,
        tglInstalasi
      ];
}
