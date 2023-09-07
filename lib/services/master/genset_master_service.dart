// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class GensetMasterService {
  Future<GensetMasterModel> postGensetMaster(
      {required int gensetId,
      required String sn,
      required String merkEngine,
      required String merk,
      required String kapasitas,
      required String merkGen,
      required String maxFuel,
      required String bahanBakar,
      required String accu,
      required String merkAccu,
      required String tipeBattCharger,
      required String switchGenset,
      required DateTime tglInstalasi}) async {
    late Uri url = UrlService().api('genset');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': gensetId,
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
      'tgl_instalasi': tglInstalasi
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

  Future<GensetMasterModel> editGensetMaster({
    required int gensetId,
    required String sn,
    required String merkEngine,
    required String merk,
    required String kapasitas,
    required String merkGen,
    required String maxFuel,
    required String bahanBakar,
    required String accu,
    required String merkAccu,
    required String tipeBattCharger,
    required String switchGenset,
  }) async {
    late Uri url = UrlService().api('edit-genset');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': gensetId,
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
      'switch': switchGenset
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
