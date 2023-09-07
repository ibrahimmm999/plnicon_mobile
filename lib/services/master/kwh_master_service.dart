// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class KwhMasterService {
  Future<KwhMasterModel> postKwhMaster(
      {required int kwhId,
      required int popId,
      required String daya,
      required String arester,
      required String aresterType,
      required String capmcbr,
      required String capmcbs,
      required String capmcbt,
      required String cos,
      required String cosType,
      required String jumlahPhasa,
      required String warnaKabelR,
      required String warnaKabelS,
      required String warnaKabelT,
      required String warnaKabelN,
      required String warnaKabelG,
      required String luasKabelR,
      required String luasKabelS,
      required String luasKabelT,
      required String luasKabelN,
      required DateTime tglInstalasi}) async {
    late Uri url = UrlService().api('kwh');

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
      'tgl_instalasi': tglInstalasi
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

  Future<KwhMasterModel> editKwhMaster({
    required int kwhId,
    required int popId,
    required String daya,
    required String arester,
    required String aresterType,
    required String capmcbr,
    required String capmcbs,
    required String capmcbt,
    required String cos,
    required String cosType,
    required String jumlahPhasa,
    required String warnaKabelR,
    required String warnaKabelS,
    required String warnaKabelT,
    required String warnaKabelN,
    required String warnaKabelG,
    required String luasKabelR,
    required String luasKabelS,
    required String luasKabelT,
    required String luasKabelN,
  }) async {
    late Uri url = UrlService().api('edit-kwh');

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
