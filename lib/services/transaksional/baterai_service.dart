// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/nilai/baterai_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class BateraiService {
  Future<List<BateraiNilaiModel>> getBaterai({required String token}) async {
    var url = UrlService().api('baterai-nilai');
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
      List<BateraiNilaiModel> baterai = List<BateraiNilaiModel>.from(
        data.map((e) => BateraiNilaiModel.fromJson(e)),
      );
      return baterai;
    } else {
      throw "Get data baterai failed";
    }
  }

  Future<List<BateraiNilaiModel>> getBateraiByPmAndMaster(
      {required int pmId, required int bateraiId}) async {
    var url =
        UrlService().api('baterai-nilai?pm_id=$pmId&baterai_id=$bateraiId');
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
      List<BateraiNilaiModel> baterai = List<BateraiNilaiModel>.from(
        data.map((e) => BateraiNilaiModel.fromJson(e)),
      );
      return baterai;
    } else {
      throw "Get data baterai failed";
    }
  }

  Future<BateraiNilaiModel> postBaterai(
      {required int bateraiId,
      required int pmId,
      required double load,
      required double groupVBank,
      required int timeDischarge,
      required int stopUjiBaterai,
      required double performance,
      required double sisaKapasitas,
      required double kemampuanBackUpTime,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('baterai-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'baterai_id': bateraiId,
      'pm_id': pmId,
      'load': load,
      'group_vbank': groupVBank,
      'time_discharge': timeDischarge,
      'stop_uji_baterai': stopUjiBaterai,
      'performance': performance,
      'sisa_kapasitas': sisaKapasitas,
      'kemampuan_backup_time': kemampuanBackUpTime,
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
      return BateraiNilaiModel.fromJson(data);
    } else {
      throw "Post data baterai failed";
    }
  }

  Future<BateraiNilaiModel> editBaterai(
      {required int bateraiId,
      required int id,
      required int pmId,
      required double load,
      required double groupVBank,
      required int timeDischarge,
      required int stopUjiBaterai,
      required double performance,
      required double sisaKapasitas,
      required double kemampuanBackUpTime,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('edit-baterai-nilai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'id': id,
      'baterai_id': bateraiId,
      'pm_id': pmId,
      'load': load,
      'group_vbank': groupVBank,
      'time_discharge': timeDischarge,
      'stop_uji_baterai': stopUjiBaterai,
      'performance': performance,
      'sisa_kapasitas': sisaKapasitas,
      'kemampuan_backup_time': kemampuanBackUpTime,
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
      return BateraiNilaiModel.fromJson(data);
    } else {
      throw "Edit data baterai failed";
    }
  }

  Future<bool> postFotoBaterai(
      {required int bateraiNilaiId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('baterai-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['baterai_nilai_id'] = bateraiNilaiId.toString();
    request.fields['deskripsi'] = description;
    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto baterai failed";
    }
  }

  Future<bool> deleteImage({required int imageId}) async {
    late Uri url = UrlService().api('delete-baterai-foto');
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
