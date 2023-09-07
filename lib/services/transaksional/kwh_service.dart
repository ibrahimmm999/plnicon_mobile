// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/nilai/kwh_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class KwhService {
  Future<List<KwhNilaiModel>> getKwh({required String token}) async {
    var url = UrlService().api('kwh-nilai');
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

  Future<KwhNilaiModel> postKwh(
      {required int kwhId,
      required int pmId,
      required double loadr,
      required double loads,
      required double loadt,
      required double vrn,
      required double vsn,
      required double vtn,
      required double vng,
      required double vrs,
      required double vrt,
      required double vst,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('kwh-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'kwh_id': kwhId,
      'pm_id': pmId,
      'loadr': loadr,
      'loads': loads,
      'loadt': loadt,
      'vrn': vrn,
      'vsn': vsn,
      'vtn': vtn,
      'vng': vng,
      'vrs': vrs,
      'vrt': vrt,
      'vst': vst,
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
      return KwhNilaiModel.fromJson(data);
    } else {
      throw "Post data kwh failed";
    }
  }

  Future<bool> postFotoKwh(
      {required int kwhNilaiId, required Map<String, String> foto}) async {
    late Uri url = UrlService().api('kwh-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    foto.forEach((key, value) async {
      var body = {
        'kwh_nilai_id': kwhNilaiId,
        'fotoFile': key,
        'description': value
      };
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print(response.request);
      } else {
        throw "Post foto kwh failed";
      }
    });
    return true;
  }
}
