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

  Future<List<InverterNilaiModel>> getInverterByPmAndMaster(
      {required int pmId, required int inverterId}) async {
    var url =
        UrlService().api('inverter-nilai?pm_id=$pmId&inverter_id=$inverterId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      print(data);
      List<InverterNilaiModel> inverter = List<InverterNilaiModel>.from(
        data.map((e) => InverterNilaiModel.fromJson(e)),
      );
      return inverter;
    } else {
      throw "Get data inverter failed";
    }
  }

  Future<InverterNilaiModel> postInverter({
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

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return InverterNilaiModel.fromJson(data);
    } else {
      throw "Post data inverter failed";
    }
  }

  Future<InverterNilaiModel> editInverter({
    required int id,
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
    late Uri url = UrlService().api('edit-inverter-nilai');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var body = {
      'id': id,
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return InverterNilaiModel.fromJson(data);
    } else {
      throw "Post data inverter failed";
    }
  }

  Future<List<InverterNilaiModel>> getByPmAndMaster(
      {required int pmId, required int inverterId}) async {
    var url =
        UrlService().api('inverter-nilai?pm_id=$pmId&inverter_id=$inverterId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      print(data);
      List<InverterNilaiModel> inverter = List<InverterNilaiModel>.from(
        data.map((e) => InverterNilaiModel.fromJson(e)),
      );
      return inverter;
    } else {
      throw "Get data inverter failed";
    }
  }

  Future<bool> postFotoInverter(
      {required int inverterNilaiId,
      required String urlFoto,
      required String description}) async {
    late Uri url = UrlService().api('inverter-foto');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };
    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    request.fields['inverter_nilai_id'] = inverterNilaiId.toString();
    request.fields['deskripsi'] = description;
    request.files.add(await http.MultipartFile.fromPath('fotoFile', urlFoto));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      print(data);
      return true;
    } else {
      throw "Add foto inverter failed";
    }
  }
}
