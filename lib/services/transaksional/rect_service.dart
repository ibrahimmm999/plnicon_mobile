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

  Future<List<RectNilaiModel>> getRectByPmAndMaster(
      {required int pmId, required int rectId}) async {
    var url = UrlService().api('rect-nilai?pm_id=$pmId&rect_id=$rectId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      print(data);
      List<RectNilaiModel> rect = List<RectNilaiModel>.from(
        data.map((e) => RectNilaiModel.fromJson(e)),
      );
      return rect;
    } else {
      throw "Get data rect failed";
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

  Future<bool> postFotoRect(
      {required int rectNilaiId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('rect-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['rect_nilai_id'] = rectNilaiId.toString();
    request.fields['deskripsi'] = description;
    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto rect failed";
    }
  }
}
