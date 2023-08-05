import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/pop_model.dart';

class PmModel extends Equatable {
  final int id;
  final String pmKode;
  final int popId;
  final int userId;
  final String status;
  final String statusApproval;
  final DateTime plan;
  final DateTime realisasi;
  final String jenis;
  final String kategori;
  final String detailPm;
  final PopModel pop;

  const PmModel({
    required this.id,
    required this.pmKode,
    required this.popId,
    required this.userId,
    required this.status,
    required this.statusApproval,
    required this.plan,
    required this.realisasi,
    required this.jenis,
    required this.kategori,
    required this.detailPm,
    required this.pop,
  });

  factory PmModel.fromJson(Map<String, dynamic> json) {
    return PmModel(
        id: json['id'],
        pmKode: json['pm_kode'],
        popId: json['pop_id'],
        userId: json['user_id'],
        status: json['status'],
        statusApproval: json['status_approval'],
        plan: DateTime.parse(json['plan']),
        realisasi: DateTime.parse(json['realisasi']),
        jenis: json['jenis'],
        kategori: json['kategori'],
        detailPm: json['detail_pm'],
        pop: PopModel.fromJson(json['datapop']));
  }

  @override
  List<Object?> get props => [
        id,
        pmKode,
        popId,
        userId,
        status,
        statusApproval,
        plan,
        realisasi,
        jenis,
        kategori,
        detailPm,
        pop
      ];
}
