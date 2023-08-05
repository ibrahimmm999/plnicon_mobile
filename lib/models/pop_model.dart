import 'package:equatable/equatable.dart';

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

  const PopModel({
    required this.id,
    required this.popKode,
    required this.nama,
    required this.koordinat,
    required this.alamat,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.building,
    required this.tipe,
  });

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
        tipe
      ];
}
