// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/rack_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class RackMasterService {
  Future<RackMasterModel> postRackMaster({
    required int nomorRack,
    required String lokasi,
    required int popId,
    String? tglInstalasi,
  }) async {
    late Uri url = UrlService().api('data-rack');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'nomor_rack': nomorRack,
      'lokasi': lokasi,
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
      return RackMasterModel.fromJson(data);
    } else {
      throw "Post data rack failed";
    }
  }

  Future<RackMasterModel> editRackMaster({
    required int rackId,
    required int popId,
    required int nomorRack,
    required String lokasi,
    String? tglInstalasi,
  }) async {
    late Uri url = UrlService().api('edit-data-rack');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': rackId,
      'pop_id': popId,
      'nomor_rack': nomorRack,
      'lokasi': lokasi,
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
      return RackMasterModel.fromJson(data);
    } else {
      throw "Edit data rack failed";
    }
  }

  Future<bool> deleteMaster({required int id}) async {
    late Uri url = UrlService().api('delete-data-rack');

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
}
