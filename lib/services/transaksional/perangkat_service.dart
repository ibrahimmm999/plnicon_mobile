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

  Future<List<PerangkatNilaiModel>> getAcByPmAndMaster(
      {required int pmId, required int perangkatId}) async {
    var url = UrlService()
        .api('perangkat-nilai?pm_id=$pmId&perangkat_id=$perangkatId');
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

  Future<bool> postFotoPerangkat(
      {required int perangkatNilaiId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('perangkat-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['perangkat_nilai_id'] = perangkatNilaiId.toString();
    request.fields['deskripsi'] = description;
    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto perangkat failed";
    }
  }
}
