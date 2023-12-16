// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/perangkat_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class PerangkatMasterService {
  Future<PerangkatMasterModel> postPerangkatMaster({
    required String nama,
    required int rackId,
    required String merk,
    required String sumberMain,
    required String sumberBackup,
    required String terminasi,
    required String jenis,
    required String tipe,
    String? tglInstalasi,
  }) async {
    late Uri url = UrlService().api('data-perangkat');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'rack_id': rackId,
      'nama': nama,
      'sumber_main': sumberMain,
      'merk': merk,
      'sumber_backup': sumberBackup,
      'terminasi': terminasi,
      'jenis': jenis,
      'tipe': tipe,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
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
        return PerangkatMasterModel.fromJson(data);
      } else {
        throw "Post data failed";
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> deleteMaster({required int id}) async {
    late Uri url = UrlService().api('delete-data-perangkat');

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
        throw "Delete data failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PerangkatMasterModel> editMaster({
    required String nama,
    required int rackId,
    required int perangkatId,
    required String merk,
    required String sumberMain,
    required String sumberBackup,
    required String terminasi,
    required String jenis,
    required String tipe,
    String? tglInstalasi,
  }) async {
    late Uri url = UrlService().api('edit-data-perangkat');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': perangkatId,
      'rack_id': rackId,
      'nama': nama,
      'sumber_main': sumberMain,
      'merk': merk,
      'sumber_backup': sumberBackup,
      'terminasi': terminasi,
      'jenis': jenis,
      'tipe': tipe,
      'tgl_instalasi': tglInstalasi ??
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return PerangkatMasterModel.fromJson(data);
    } else {
      throw "Edit data failed";
    }
  }
}
