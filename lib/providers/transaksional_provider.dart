import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/environment_master_model.dart';
import 'package:plnicon_mobile/models/nilai/ac_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/baterai_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/exalarm_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/genset_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/inverter_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/kwh_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/pdb_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/perangkat_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/rect_nilai_model.dart';
import 'package:plnicon_mobile/services/master/exalarm_service.dart';
import 'package:plnicon_mobile/services/transaksional/ac_service.dart';
import 'package:plnicon_mobile/services/transaksional/baterai_service.dart';
import 'package:plnicon_mobile/services/transaksional/genset_service.dart';
import 'package:plnicon_mobile/services/transaksional/inverter_service.dart';
import 'package:plnicon_mobile/services/transaksional/kwh_service.dart';
import 'package:plnicon_mobile/services/transaksional/pdb_service.dart';
import 'package:plnicon_mobile/services/transaksional/rect_service.dart';

class TransaksionalProvider extends ChangeNotifier {
  bool found = false;
  List<AcNilaiModel> _listAc = [];
  List<KwhNilaiModel> _listKwh = [];
  List<RectNilaiModel> _listRect = [];
  List<BateraiNilaiModel> _listBaterai = [];
  List<InverterNilaiModel> _listInverter = [];
  List<PdbNilaiModel> _listPdb = [];
  List<EnvironmentMasterModel> _listEnvironment = [];
  List<GensetNilaiModel> _listGenset = [];
  List<PerangkatNilaiModel> _listPerangkat = [];
  List<ExAlarmNilaiModel> _listExalarm = [];

  List<AcNilaiModel> get listAc => _listAc;
  List<KwhNilaiModel> get listKwh => _listKwh;
  List<RectNilaiModel> get listRect => _listRect;
  List<BateraiNilaiModel> get listBaterai => _listBaterai;
  List<InverterNilaiModel> get listInverter => _listInverter;
  List<EnvironmentMasterModel> get listEnvironment => _listEnvironment;
  List<PdbNilaiModel> get listPdb => _listPdb;
  List<GensetNilaiModel> get listGenset => _listGenset;
  List<PerangkatNilaiModel> get listPerangkat => _listPerangkat;
  List<ExAlarmNilaiModel> get listExalarm => _listExalarm;

  void setAc(AcNilaiModel ac) {
    for (var i = 0; i < _listAc.length; i++) {
      if (_listAc[i].pmId == ac.pmId && _listAc[i].acId == ac.acId) {
        _listAc[i] = ac;
        found = true;
        notifyListeners();
        break;
      }
    }
    if (!found) {
      _listAc.add(ac);
      found = false;
    }
    notifyListeners();
  }

  Future<bool> getAc(int pmId, int acId) async {
    try {
      _listAc = await AcService().getAcByPmAndMaster(acId: acId, pmId: pmId);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getGenset(int pmId, int gensetId) async {
    try {
      _listGenset = await GensetService()
          .getGensetByPmAndMaster(pmId: pmId, gensetId: gensetId);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getExalarm(int pmId, int exalarm) async {
    try {
      _listExalarm = await ExAlarmService().getExAlarm();
      print("TOTOTOT");
      print(_listExalarm);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getBaterai(int pmId, int batId) async {
    try {
      _listBaterai = await BateraiService()
          .getBateraiByPmAndMaster(bateraiId: batId, pmId: pmId);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getInverter(int pmId, int inverterId) async {
    try {
      _listInverter = await InverterService()
          .getByPmAndMaster(inverterId: inverterId, pmId: pmId);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getRect(int pmId, int rectId) async {
    try {
      _listRect =
          await RectService().getRectByPmAndMaster(rectId: rectId, pmId: pmId);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getKwh(int pmId, int kwhId) async {
    try {
      _listKwh = await KwhService()
          .getKwhByPmAndMaster(kwhId: kwhId.toString(), pmId: pmId.toString());
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getEnv(int pmId, int kwhId) async {
    try {
      _listKwh = await KwhService()
          .getKwhByPmAndMaster(kwhId: kwhId.toString(), pmId: pmId.toString());
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getPdb(int pmId, int pdbId) async {
    try {
      _listPdb = await PdbService()
          .getPdbByPmAndMaster(pdbId: pdbId.toString(), pmId: pmId.toString());
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  set setListKwh(List<KwhNilaiModel> kwh) {
    _listKwh = kwh;
    notifyListeners();
  }

  set setListRect(RectNilaiModel rect) {
    _listRect.add(rect);
    notifyListeners();
  }

  set setListBaterai(List<BateraiNilaiModel> batt) {
    _listBaterai = batt;
    notifyListeners();
  }

  set setListInverter(List<InverterNilaiModel> inv) {
    _listInverter = inv;
    notifyListeners();
  }

  set setListPdb(List<PdbNilaiModel> pdb) {
    _listPdb = pdb;
    notifyListeners();
  }

  set setListGenset(List<GensetNilaiModel> genset) {
    _listGenset = genset;
    notifyListeners();
  }

  set setListPerangkat(List<PerangkatNilaiModel> perangkat) {
    _listPerangkat = perangkat;
    notifyListeners();
  }

  // set setListEnvironment(List<EnvironmentModel> env) {
  //   _listEnvironment = env;
  //   notifyListeners();
  // }

  Future<bool> addAc(AcNilaiModel ac) async {
    try {
      await AcService().postAc(
          acId: ac.acId,
          pmId: ac.pmId,
          suhuAc: ac.suhuAc,
          hasilPengujian: ac.hasilPengujian,
          temuan: ac.temuan,
          rekomendasi: ac.rekomendasi);
      for (var i = 0; i < _listAc.length; i++) {
        if (_listAc[i].pmId == ac.pmId && _listAc[i].acId == ac.acId) {
          _listAc.removeAt(i);
          break;
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print("ERROR ADD AC: $e");
      return false;
    }
  }

  void addKwh(KwhNilaiModel kwh) {
    _listKwh.add(kwh);
    notifyListeners();
  }

  void addRect(RectNilaiModel rect) {
    _listRect.add(rect);
    notifyListeners();
  }

  void addBaterai(BateraiNilaiModel batt) {
    _listBaterai.add(batt);
    notifyListeners();
  }

  void addInverter(InverterNilaiModel inv) {
    _listInverter.add(inv);
    notifyListeners();
  }

  void addPdb(PdbNilaiModel pdb) {
    _listPdb.add(pdb);
    notifyListeners();
  }

  void addGenset(GensetNilaiModel genset) {
    _listGenset.add(genset);
    notifyListeners();
  }

  void addPerangkat(PerangkatNilaiModel perangkat) {
    _listPerangkat.add(perangkat);
    notifyListeners();
  }

  // void addEnvironment(EnvironmentModel env) {
  //   _listEnvironment.add(env);
  //   notifyListeners();
  // }
}
