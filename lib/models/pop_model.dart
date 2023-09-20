import 'package:equatable/equatable.dart';
import 'package:plnicon_mobile/models/master/ac_master_model.dart';
import 'package:plnicon_mobile/models/master/ats_master_model.dart';
import 'package:plnicon_mobile/models/master/environment_master_model.dart';
import 'package:plnicon_mobile/models/master/exalarm_master_model.dart';
import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/models/master/inverter_master_model.dart';
import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/models/master/pdb_master_model.dart';
import 'package:plnicon_mobile/models/master/rack_master_model.dart';
import 'package:plnicon_mobile/models/master/rect_master_model.dart';

class PopModel extends Equatable {
  final int id;
  final String popKode;
  final String nama;
  final String koordinat;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String kota;
  final String building;
  final String tipe;
  final List<AcMasterModel> listAc;
  final List<AtsMasterModel> listAts;
  final List<InverterMasterModel> listInverter;
  final List<GensetMasterModel> listGenset;
  final List<RackMasterModel> listRack;
  final List<RectMasterModel> listRect;
  final List<PdbMasterModel> listPdb;
  final List<ExAlarmMasterModel> listExAlarm;
  final List<EnvironmentMasterModel> listEnvironment;
  final List<KwhMasterModel> listKwh;

  const PopModel(
      {required this.id,
      required this.popKode,
      required this.nama,
      required this.koordinat,
      required this.alamat,
      required this.kelurahan,
      required this.kecamatan,
      required this.kota,
      required this.building,
      required this.tipe,
      required this.listAc,
      required this.listAts,
      required this.listKwh,
      required this.listInverter,
      required this.listGenset,
      required this.listPdb,
      required this.listRack,
      required this.listRect,
      required this.listEnvironment,
      required this.listExAlarm});

  factory PopModel.fromJson(Map<String, dynamic> json) {
    return PopModel(
      id: json['id'],
      popKode: json['pop_kode'],
      nama: json['nama'],
      koordinat: json['koordinat'],
      alamat: json['alamat'],
      kelurahan: json['kelurahan'],
      kecamatan: json['kecamatan'],
      kota: json['kota'],
      building: json['building'],
      tipe: json['tipe'],
      listAc: json['ac'] == null
          ? []
          : List<AcMasterModel>.from(
              json['ac'].map((x) => AcMasterModel.fromJson(x))),
      listAts: json['ats'] == null
          ? []
          : List<AtsMasterModel>.from(
              json['ats'].map((x) => AtsMasterModel.fromJson(x))),
      listKwh: json['kwh'] == null
          ? []
          : List<KwhMasterModel>.from(
              json['kwh'].map((x) => KwhMasterModel.fromJson(x))),
      listInverter: json['inverter'] == null
          ? []
          : List<InverterMasterModel>.from(
              json['inverter'].map((x) => InverterMasterModel.fromJson(x))),
      listGenset: json['genset'] == null
          ? []
          : List<GensetMasterModel>.from(
              json['genset'].map((x) => GensetMasterModel.fromJson(x))),
      listPdb: json['pdb'] == null
          ? []
          : List<PdbMasterModel>.from(
              json['pdb'].map((x) => PdbMasterModel.fromJson(x))),
      listRack: json['rack'] == null
          ? []
          : List<RackMasterModel>.from(
              json['rack'].map((x) => RackMasterModel.fromJson(x))),
      listEnvironment: json['environment'] == null
          ? []
          : List<EnvironmentMasterModel>.from(json['environment']
              .map((x) => EnvironmentMasterModel.fromJson(x))),
      listRect: json['rect'] == null
          ? []
          : List<RectMasterModel>.from(
              json['rect'].map((x) => RectMasterModel.fromJson(x))),
      listExAlarm: json['ex_alarm'] == null
          ? []
          : List<ExAlarmMasterModel>.from(
              json['ex_alarm'].map((x) => ExAlarmMasterModel.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [
        id,
        popKode,
        nama,
        koordinat,
        alamat,
        kelurahan,
        kecamatan,
        kota,
        building,
        tipe,
        listAc,
        listAts,
        listGenset,
        listInverter,
        listRack,
        listRect,
        listExAlarm,
        listEnvironment,
        listPdb,
        listKwh,
      ];
}
