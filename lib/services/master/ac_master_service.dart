// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/ac_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class AcMasterService {
  Future<AcMasterModel> postAcMaster({
    required String nama,
    required String kondisi,
    required String merk,
    required String kapasitas,
    required String tekananFreon,
    required String modeHidup,
    required int popId,
  }) async {
    late Uri url = UrlService().api('air-conditioner');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'nama': nama,
      'kondisi': kondisi,
      'merk': merk,
      'kapasitas': kapasitas,
      'tekanan_freon': tekananFreon,
      'mode_hidup': modeHidup,
      'tgl_instalasi': "2023-08-08 00:00:00"
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return AcMasterModel.fromJson(data);
      } else {
        throw "Post data ac failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AcMasterModel> editAcMaster({
    required int acId,
    required int popId,
    required String nama,
    required String kondisi,
    required String merk,
    required String kapasitas,
    required String tekananFreon,
    required String modeHidup,
  }) async {
    late Uri url = UrlService().api('edit-air-conditioner');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': acId,
      'pop_id': popId,
      'nama': nama,
      'kondisi': kondisi,
      'merk': merk,
      'kapasitas': kapasitas,
      'tekanan_freon': tekananFreon,
      'mode_hidup': modeHidup,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return AcMasterModel.fromJson(data);
    } else {
      throw "Edit data ac failed";
    }
  }
}
