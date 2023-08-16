// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/nilai/baterai_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class BateraiService {
  Future<List<BateraiNilaiModel>> getBaterai({required String token}) async {
    var url = UrlService().api('baterai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      // print(data);
      List<BateraiNilaiModel> baterai = List<BateraiNilaiModel>.from(
        data.map((e) => BateraiNilaiModel.fromJson(e)),
      );
      return baterai;
    } else {
      throw "Get data baterai failed";
    }
  }

  Future<BateraiNilaiModel> postBaterai(
      {required String bateraiId,
      required String pmId,
      required double load,
      required double groupVBank,
      required double cellV1,
      required double cellV2,
      required double cellV3,
      required double cellV4,
      required int timeDischarge,
      required int stopUjiBaterai,
      required double performance,
      required double sisaKapasitas,
      required double kemampuanBackUpTime,
      required int jumlahBateraiRusak,
      required String temuan,
      required String rekomendasi}) async {
    late Uri url = UrlService().api('baterai');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'baterai_id': bateraiId,
      'pm_id': pmId,
      'load': load,
      'group_vbank': groupVBank,
      'cell_v1': cellV1,
      'cell_v2': cellV2,
      'cell_v3': cellV3,
      'cell_v4': cellV4,
      'time_discharge': timeDischarge,
      'stop_uji_baterai': stopUjiBaterai,
      'performance': performance,
      'sisa_kapasitas': sisaKapasitas,
      'kemampuan_backup_time': kemampuanBackUpTime,
      'jumlah_baterai_rusak': jumlahBateraiRusak,
      'temuan': temuan,
      'rekomendasi': rekomendasi
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return BateraiNilaiModel.fromJson(data);
    } else {
      throw "Post data baterai failed";
    }
  }
}