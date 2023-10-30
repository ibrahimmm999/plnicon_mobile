// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/inverter_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class InverterMasterService {
  Future<InverterMasterModel> postInverterMaster({
    required String sn,
    required String kondisi,
    required String merk,
    required int kapasitas,
    required String tipe,
    required int popId,
  }) async {
    late Uri url = UrlService().api('inverter');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'sn': sn,
      'kondisi': kondisi,
      'merk': merk,
      'kapasitas': kapasitas,
      'tipe': tipe,
      'tgl_instalasi': "2023-08-08 00:00:00"
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return InverterMasterModel.fromJson(data);
    } else {
      throw "Post data inverter failed";
    }
  }

  Future<InverterMasterModel> deleteInverterMaster({required int id}) async {
    late Uri url = UrlService().api('delete-inverter');

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
        var data = jsonDecode(response.body)['data'];
        return InverterMasterModel.fromJson(data);
      } else {
        throw "Delete data inverter failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<InverterMasterModel> editInverterMaster({
    required int inverterId,
    required int popId,
    required String sn,
    required String kondisi,
    required String merk,
    required int kapasitas,
    required String tipe,
  }) async {
    late Uri url = UrlService().api('edit-inverter');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': inverterId,
      'pop_id': popId,
      'sn': sn,
      'kondisi': kondisi,
      'merk': merk,
      'kapasitas': kapasitas,
      'tipe': tipe,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return InverterMasterModel.fromJson(data);
    } else {
      throw "Edit data inverter failed";
    }
  }
}
