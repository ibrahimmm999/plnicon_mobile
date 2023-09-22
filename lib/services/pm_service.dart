// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/models/pop_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;

class PmService {
  Future<List<PmModel>> getPm({required String token}) async {
    var url = UrlService().api('jadwalpm-user');
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

      List<PmModel> pm = List<PmModel>.from(
        data.map((e) => PmModel.fromJson(e)),
      );

      return pm;
    } else {
      throw "Get data pm failed";
    }
  }

  Future<PmModel> editPm(
      {required String token,
      required int userId,
      required String statusApproval,
      required DateTime plan,
      required DateTime realisasi,
      required String jenis,
      required String kategori,
      required String detailPm,
      required int pmId,
      required int popId,
      required String wilayah,
      required String area,
      required String status}) async {
    late Uri url = UrlService().api('edit-jadwalpm');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    print(plan);
    print(realisasi);

    var body = {
      'id': pmId,
      'status': status,
      'user_id': userId,
      'status_approval': statusApproval,
      'plan': plan.toString(),
      'realisasi': realisasi.toString(),
      'jenis': jenis,
      'kategori': kategori,
      'detail_pm': detailPm,
      'pop_id': popId,
      'wilayah': wilayah,
      'area': area,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return PmModel.fromJson(data);
    } else {
      throw jsonDecode(response.body)['data']['error'];
    }
  }
}
