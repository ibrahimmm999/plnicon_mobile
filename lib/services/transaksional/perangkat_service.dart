// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/nilai/perangkat_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class PerangkatService {
  Future<List<PerangkatNilaiModel>> getPerangkat(
      {required String token}) async {
    var url = UrlService().api('perangkat');
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
      List<PerangkatNilaiModel> perangkat = List<PerangkatNilaiModel>.from(
        data.map((e) => PerangkatNilaiModel.fromJson(e)),
      );
      return perangkat;
    } else {
      throw "Get data perangkat failed";
    }
  }

  Future<PerangkatNilaiModel> postPerangkat(
      {required int perangkatId,
      required String pmId,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('perangkat');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'perangkat_id': perangkatId,
      'pm_id': pmId,
      'temuan': temuan,
      'rekomendasi': rekomendasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return PerangkatNilaiModel.fromJson(data);
    } else {
      throw "Post data perangkat failed";
    }
  }
}
