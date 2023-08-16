// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/nilai/inverter_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/kwh_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/pdb_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;

class TransaksionalService {
  Future<List<InverterNilaiModel>> getInverter({required String token}) async {
    var url = UrlService().api('inverter');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      // print(data);
      List<InverterNilaiModel> inverter = List<InverterNilaiModel>.from(
        data.map((e) => InverterNilaiModel.fromJson(e)),
      );
      return inverter;
    } else {
      throw "Get data inverter failed";
    }
  }

  Future<List<KwhNilaiModel>> getKwh({required String token}) async {
    var url = UrlService().api('kwh');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      // print(data);
      List<KwhNilaiModel> kwh = List<KwhNilaiModel>.from(
        data.map((e) => KwhNilaiModel.fromJson(e)),
      );
      return kwh;
    } else {
      throw "Get data kwh failed";
    }
  }

  Future<List<PdbNilaiModel>> getPdb({required String token}) async {
    var url = UrlService().api('pdb');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      // print(data);
      List<PdbNilaiModel> pdb = List<PdbNilaiModel>.from(
        data.map((e) => PdbNilaiModel.fromJson(e)),
      );
      return pdb;
    } else {
      throw "Get data pdb failed";
    }
  }
}
