// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:plnicon_mobile/models/foto_model.dart';
import 'package:plnicon_mobile/models/nilai/ac_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/inverter_nilai_model.dart';
import 'package:plnicon_mobile/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'package:plnicon_mobile/services/user_service.dart';

class InverterService {
  Future<List<InverterNilaiModel>> getInverter({required String token}) async {
    var url = UrlService().api('inverter-nilai');
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
      List<InverterNilaiModel> inverter = List<InverterNilaiModel>.from(
        data.map((e) => InverterNilaiModel.fromJson(e)),
      );
      return inverter;
    } else {
      throw "Get data inverter failed";
    }
  }

  Future<bool> postInverter({
    required int inverterId,
    required int pmId,
    required String load,
    required String inputAc,
    required String inputDc,
    required String outputDc,
    required String mainfall,
    required String hasilUji,
    required String temuan,
    required String rekomendasi,
  }) async {
    late Uri url = UrlService().api('inverter-nilai');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'inverter_id': inverterId,
      'pm_id': pmId,
      'load': load,
      'input_ac': inputAc,
      'input_dc': inputDc,
      'output_dc': outputDc,
      'mainfall': mainfall,
      'temuan': temuan,
      'rekomendasi': rekomendasi,
    };
    print(body);

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.request);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return true;
    } else {
      throw "Post data inverter failed";
    }
  }

  Future<bool> postFotoInverter(
      {required int inverterNilaiId, required Map<String, String> foto}) async {
    late Uri url = UrlService().api('inverter-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    foto.forEach((key, value) async {
      var body = {
        'inverter_nilai_id': inverterNilaiId,
        'fotoFile': key,
        'description': value
      };
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print(response.request);
      } else {
        throw "Post foto inverter failed";
      }
    });
    return true;
  }
}
