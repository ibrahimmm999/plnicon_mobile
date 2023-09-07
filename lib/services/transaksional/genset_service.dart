// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/foto_model.dart';
import 'package:plnicon_mobile/models/nilai/genset_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class GensetService {
  Future<List<GensetNilaiModel>> getGenset({required String token}) async {
    var url = UrlService().api('genset-nilai');
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
      List<GensetNilaiModel> genset = List<GensetNilaiModel>.from(
        data.map((e) => GensetNilaiModel.fromJson(e)),
      );
      return genset;
    } else {
      throw "Get data genset failed";
    }
  }

  Future<GensetNilaiModel> postGenset(
      {required int gensetId,
      required int pmId,
      required int fuel,
      required double hourMeter,
      required double teganganAccu,
      required double teganganCharger,
      required double arusCharger,
      required String failOverTest,
      required double tempOn,
      required double ujiBebanVolt,
      required double ujiBebanArus,
      required double ujiTanpaBebanVolt,
      required double ujiTanpaBebanArus,
      required String indoorClean,
      required String outdoorClean,
      required String kartuGantungUrl,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('genset-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'genset_id': gensetId,
      'pm_id': pmId,
      'fuel': fuel,
      'hour_meter': hourMeter,
      'tegangan_accu': teganganAccu,
      'tegangan_charger': teganganCharger,
      'arus_charger': arusCharger,
      'fail_over_test': failOverTest,
      'temp_on': tempOn,
      'uji_beban_volt': ujiBebanVolt,
      'uji_beban_arus': ujiBebanArus,
      'uji_tanpa_beban_volt': ujiTanpaBebanVolt,
      'uji_tanpa_beban_arus': ujiTanpaBebanArus,
      'indoor_clean': indoorClean,
      'outdoor_clean': outdoorClean,
      'kartu_gantung_url': kartuGantungUrl,
      'temuan': temuan,
      'rekomendasi': rekomendasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );
    print(response.request);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return GensetNilaiModel.fromJson(data);
    } else {
      throw "Post data genset failed";
    }
  }

  Future<bool> postFotoGenset(
      {required int gensetNilaiId, required FotoModel foto}) async {
    late Uri url = UrlService().api('genset-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);
    var body = {
      'genset_nilai_id': gensetNilaiId,
      'fotoFile': foto.url,
      'description': foto.deskripsi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.request);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return true;
    } else {
      throw "Post foto genset failed";
    }
  }
}
