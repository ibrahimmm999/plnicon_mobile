// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/foto_model.dart';
import 'package:plnicon_mobile/models/nilai/ac_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class AcService {
  Future<List<AcNilaiModel>> getAc({required String token}) async {
    var url = UrlService().api('air-conditioner-nilai');
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
      List<AcNilaiModel> ac = List<AcNilaiModel>.from(
        data.map((e) => AcNilaiModel.fromJson(e)),
      );
      return ac;
    } else {
      throw "Get data ac failed";
    }
  }

  Future<AcNilaiModel> postAc(
      {required int acId,
      required int pmId,
      required int suhuAc,
      required String hasilPengujian,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('air-conditioner-nilai');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'ac_id': acId,
      'pm_id': pmId,
      'suhu_ac': suhuAc,
      'hasil_pengujian': hasilPengujian,
      'temuan': temuan,
      'rekomendasi': rekomendasi,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return AcNilaiModel.fromJson(data);
    } else {
      throw "Post data ac failed";
    }
  }

  Future<List<AcNilaiModel>> getAcByPmAndMaster(
      {required int pmId, required int acId}) async {
    var url = UrlService().api('air-conditioner-nilai?pm_id=$pmId&ac_id=$acId');
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
      List<AcNilaiModel> ac = List<AcNilaiModel>.from(
        data.map((e) => AcNilaiModel.fromJson(e)),
      );
      return ac;
    } else {
      throw "Get data ac failed";
    }
  }

  Future<AcNilaiModel> editAc(
      {required int id,
      required int acId,
      required int pmId,
      required int suhuAc,
      required String hasilPengujian,
      required String temuan,
      required List<FotoModel> foto,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('edit-air-conditioner-nilai');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': id,
      'ac_id': acId,
      'pm_id': pmId,
      'suhu_ac': suhuAc,
      'hasil_pengujian': hasilPengujian,
      'temuan': temuan,
      'rekomendasi': rekomendasi,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return AcNilaiModel.fromJson(data);
    } else {
      throw "Edit data ac failed";
    }
  }

  Future<bool> postFotoAc(
      {required int acNilaiId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('air-conditioner-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['ac_nilai_id'] = acNilaiId.toString();
    request.fields['deskripsi'] = description;

    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto ac failed";
    }
  }

  Future<bool> deleteImage({required int imageId}) async {
    late Uri url = UrlService().api('delete-air-conditioner-foto');
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

    if (response.statusCode == 200) {
      return true;
    } else {
      throw "Delete image failed";
    }
  }
}
