// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class KwhMasterService {
  Future<KwhMasterModel> postKwhMaster({
    required int popId,
    required double daya,
    required String arester,
    required String aresterType,
    required double capmcbr,
    required double capmcbs,
    required double capmcbt,
    required String cos,
    required String cosType,
    required int jumlahPhasa,
    required String warnaKabelR,
    required String warnaKabelS,
    required String warnaKabelT,
    required String warnaKabelN,
    required String warnaKabelG,
    required double luasKabelR,
    required double luasKabelS,
    required double luasKabelT,
    required double luasKabelN,
  }) async {
    late Uri url = UrlService().api('kwh-meter');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'pop_id': popId,
      'daya': daya,
      'jumlah_phasa': jumlahPhasa,
      'capmcbs': capmcbs,
      'capmcbt': capmcbt,
      'capmcbr': capmcbr,
      'cos': cos,
      'cos_type': cosType,
      'arester': arester,
      'arester_type': aresterType,
      'warna_kabelr': warnaKabelR,
      'warna_kabels': warnaKabelS,
      'warna_kabelt': warnaKabelT,
      'warna_kabeln': warnaKabelN,
      'warna_kabelg': warnaKabelG,
      'luas_kabelr': luasKabelR,
      'luas_kabels': luasKabelS,
      'luas_kabelt': luasKabelT,
      'luas_kabeln': luasKabelN,
      'tgl_instalasi': "2023-08-08 00:00:00"
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return KwhMasterModel.fromJson(data);
    } else {
      throw "Post data kwh failed";
    }
  }

  Future<KwhMasterModel> deleteKwhMaster({required int id}) async {
    late Uri url = UrlService().api('delete-kwh-meter');

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
        return KwhMasterModel.fromJson(data);
      } else {
        throw "Delete data kwh failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<KwhMasterModel> editKwhMaster({
    required int kwhId,
    required int popId,
    required double daya,
    required String arester,
    required String aresterType,
    required double capmcbr,
    required double capmcbs,
    required double capmcbt,
    required String cos,
    required String cosType,
    required int jumlahPhasa,
    required String warnaKabelR,
    required String warnaKabelS,
    required String warnaKabelT,
    required String warnaKabelN,
    required String warnaKabelG,
    required double luasKabelR,
    required double luasKabelS,
    required double luasKabelT,
    required double luasKabelN,
  }) async {
    late Uri url = UrlService().api('edit-kwh-meter');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': kwhId,
      'pop_id': popId,
      'daya': daya,
      'jumlah_phasa': jumlahPhasa,
      'capmcbs': capmcbs,
      'capmcbt': capmcbt,
      'capmcbr': capmcbr,
      'cos': cos,
      'cos_type': cosType,
      'arester': arester,
      'arester_type': aresterType,
      'warna_kabelr': warnaKabelR,
      'warna_kabels': warnaKabelS,
      'warna_kabelt': warnaKabelT,
      'warna_kabeln': warnaKabelN,
      'warna_kabelg': warnaKabelG,
      'luas_kabelr': luasKabelR,
      'luas_kabels': luasKabelS,
      'luas_kabelt': luasKabelT,
      'luas_kabeln': luasKabelN,
      'tgl_instalasi': "2023-08-08 00:00:00"
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return KwhMasterModel.fromJson(data);
    } else {
      throw "Edit data kwh failed";
    }
  }
}
