// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/foto_model.dart';
import 'package:plnicon_mobile/models/nilai/kwh_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class KwhService {
  Future<List<KwhNilaiModel>> getKwh({required String token}) async {
    var url = UrlService().api('kwh-meter-nilai');
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

  Future<List<KwhNilaiModel>> getKwhByPmAndMaster(
      {required String pmId, required String kwhId}) async {
    var url = UrlService().api('kwh-meter-nilai?pm_id=$pmId&kwh_id=$kwhId');
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
      required String loadr,
      required String loads,
      required String loadt,
      required String vrn,
      required String vsn,
      required String vtn,
      required String vng,
      required String vrs,
      required String vrt,
      required String vst,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('kwh-meter-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'kwh_id': kwhId,
      'pm_id': pmId,
      'load_r': loadr,
      'load_s': loads,
      'load_t': loadt,
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
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      return KwhNilaiModel.fromJson(data);
    } else {
      throw "Post data kwh failed";
    }
  }

  Future<KwhNilaiModel> editKwh(
      {required int id,
      required int kwhId,
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
      required List<FotoModel> foto,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('edit-kwh-meter-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'id': id,
      'kwh_id': kwhId,
      'pm_id': pmId,
      'load_r': loadr,
      'load_s': loads,
      'load_t': loadt,
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
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      return KwhNilaiModel.fromJson(data);
    } else {
      throw "Edit data kwh failed";
    }
  }

  Future<bool> postFotoKwh(
      {required int kwhNilaiId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('kwh-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['kwh_nilai_id'] = kwhNilaiId.toString();
    request.fields['deskripsi'] = description;
    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    print(response.statusCode);
    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto kwh failed";
    }
  }

  Future<bool> deleteImage({required int imageId}) async {
    late Uri url = UrlService().api('delete-kwh-foto');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'id': imageId,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print(body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw "Delete image failed";
    }
  }
}
