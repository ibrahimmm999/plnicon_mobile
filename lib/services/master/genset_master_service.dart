// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class GensetMasterService {
  Future<GensetMasterModel> postGensetMaster(
      {required int popId,
      required String sn,
      required String merkEngine,
      required String merk,
      required int kapasitas,
      required String merkGen,
      required int maxFuel,
      required String bahanBakar,
      required double accu,
      required String merkAccu,
      required String tipeBattCharger,
      required String switchGenset,
      String? tglInstalasi}) async {
    late Uri url = UrlService().api('genset');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'sn': sn,
      'merk_engine': merkEngine,
      'merk': merk,
      'kapasitas': kapasitas,
      'merk_gen': merkGen,
      'max_fuel': maxFuel,
      'bahan_bakar': bahanBakar,
      'accu': accu,
      'merk_accu': merkAccu,
      'tipe_batt_charger': tipeBattCharger,
      'switch': switchGenset,
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
      return GensetMasterModel.fromJson(data);
    } else {
      throw "Post data genset failed";
    }
  }

  Future<bool> deleteGensetMaster({required int id}) async {
    late Uri url = UrlService().api('delete-genset');

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
        throw "Delete data genset failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GensetMasterModel> editGensetMaster({
    required int gensetId,
    required int popId,
    required String sn,
    required String merkEngine,
    required String merk,
    required int kapasitas,
    required String merkGen,
    required int maxFuel,
    required String bahanBakar,
    required double accu,
    required String merkAccu,
    required String tipeBattCharger,
    required String switchGenset,
    String? tglInstalasi,
  }) async {
    late Uri url = UrlService().api('edit-genset');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': gensetId,
      'pop_id': popId,
      'sn': sn,
      'merk_engine': merkEngine,
      'merk': merk,
      'kapasitas': kapasitas,
      'merk_gen': merkGen,
      'max_fuel': maxFuel,
      'bahan_bakar': bahanBakar,
      'accu': accu,
      'merk_accu': merkAccu,
      'tipe_batt_charger': tipeBattCharger,
      'switch': switchGenset,
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
      return GensetMasterModel.fromJson(data);
    } else {
      throw "Edit data genset failed";
    }
  }
}
