// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/ats_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class AtsMasterService {
  Future<AtsMasterModel> postAtsMaster({
    required String status,
    required String sn,
    required String merk,
    required String tipe,
    String? tglInstalasi,
    required int popId,
  }) async {
    late Uri url = UrlService().api('ats');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'status': status,
      'sn': sn,
      'merk': merk,
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
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return AtsMasterModel.fromJson(data);
      } else {
        throw "Post data ats failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AtsMasterModel> editAtsMaster({
    required int atsId,
    required int popId,
    required String status,
    required String sn,
    required String merk,
    required String tipe,
    String? tglInstalasi,
  }) async {
    late Uri url = UrlService().api('edit-ats');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': atsId,
      'pop_id': popId,
      'status': status,
      'sn': sn,
      'merk': merk,
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
      return AtsMasterModel.fromJson(data);
    } else {
      throw "Edit data ats failed";
    }
  }

  Future<bool> deleteAts({required int id}) async {
    late Uri url = UrlService().api('delete-ats');

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
        throw "Delete data ats failed";
      }
    } catch (e) {
      rethrow;
    }
  }
}
