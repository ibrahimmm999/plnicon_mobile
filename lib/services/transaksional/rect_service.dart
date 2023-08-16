// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/nilai/rect_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class RectService {
  Future<List<RectNilaiModel>> getRect({required String token}) async {
    var url = UrlService().api('rect-nilai');
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
      List<RectNilaiModel> rect = List<RectNilaiModel>.from(
        data.map((e) => RectNilaiModel.fromJson(e)),
      );
      return rect;
    } else {
      throw "Get data rectifier failed";
    }
  }

  Future<RectNilaiModel> postRect(
      {required int rectId,
      required int pmId,
      required double loadr,
      required double loads,
      required double loadt,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('rect-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'rect_id': rectId,
      'pm_id': pmId,
      'loadr': loadr,
      'loads': loads,
      'loadt': loadt,
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
      return RectNilaiModel.fromJson(data);
    } else {
      throw "Post data rectifier failed";
    }
  }
}
