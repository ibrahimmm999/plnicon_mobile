// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/baterai_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class BateraiMasterService {
  Future<BateraiMasterModel> postBateraiMaster(
      {required int popId,
      required int bankId,
      required int rectId,
      required String nama,
      required String merk,
      required String tipe,
      required String kapasitas,
      required String sn,
      required String persentase,
      required String vbatt,
      String? tglInstalasi,
      required String tglUji}) async {
    late Uri url = UrlService().api('baterai');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'rect_id': rectId,
      'bank_id': bankId,
      'nama': nama,
      'merk': merk,
      'tipe': tipe,
      'kapasitas': kapasitas,
      'sn': sn,
      'vbatt': vbatt,
      'persentase': persentase,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      'tgl_uji': tglUji
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return BateraiMasterModel.fromJson(data);
    } else {
      throw "Post data baterai failed";
    }
  }

  Future<BateraiMasterModel> editBateraiMaster(
      {required int bateraiId,
      required int popId,
      required int bankId,
      required int rectId,
      required String nama,
      required String merk,
      required String tipe,
      required String kapasitas,
      required String sn,
      required String persentase,
      required String vbatt,
      String? tglInstalasi,
      required String tglUji}) async {
    late Uri url = UrlService().api('edit-baterai');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': bateraiId,
      'pop_id': popId,
      'rect_id': rectId,
      'bank_id': bankId,
      'nama': nama,
      'merk': merk,
      'tipe': tipe,
      'kapasitas': kapasitas,
      'sn': sn,
      'vbatt': vbatt,
      'persentase': persentase,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      'tgl_uji': tglUji
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return BateraiMasterModel.fromJson(data);
    } else {
      throw "Edit data baterai failed";
    }
  }

  Future<bool> delete({required int id}) async {
    late Uri url = UrlService().api('delete-baterai');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': id,
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Delete data baterai failed";
      }
    } catch (e) {
      rethrow;
    }
  }
}
