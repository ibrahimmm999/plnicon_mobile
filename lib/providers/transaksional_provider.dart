import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/nilai/ac_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/baterai_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/environment_model.dart';
import 'package:plnicon_mobile/models/nilai/genset_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/inverter_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/kwh_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/pdb_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/perangkat_nilai_model.dart';
import 'package:plnicon_mobile/models/nilai/rect_nilai_model.dart';

class TransaksionalProvider extends ChangeNotifier {
  List<AcNilaiModel> _listAc = [];
  List<KwhNilaiModel> _listKwh = [];
  List<RectNilaiModel> _listRect = [];
  List<BateraiNilaiModel> _listBaterai = [];
  List<EnvironmentModel> _listEnvironment = [];
  List<InverterNilaiModel> _listInverter = [];
  List<PdbNilaiModel> _listPdb = [];
  List<GensetNilaiModel> _listGenset = [];
  List<PerangkatNilaiModel> _listPerangkat = [];

  List<AcNilaiModel> get listAc => _listAc;
  List<KwhNilaiModel> get listKwh => _listKwh;
  List<RectNilaiModel> get listRect => _listRect;
  List<BateraiNilaiModel> get listBaterai => _listBaterai;
  List<EnvironmentModel> get listEnvironment => _listEnvironment;
  List<InverterNilaiModel> get listInverter => _listInverter;
  List<PdbNilaiModel> get listPdb => _listPdb;
  List<GensetNilaiModel> get listGenset => _listGenset;
  List<PerangkatNilaiModel> get listPerangkat => _listPerangkat;

  set setListAc(List<AcNilaiModel> ac) {
    _listAc = ac;
    notifyListeners();
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

  set setListEnvironment(List<EnvironmentModel> env) {
    _listEnvironment = env;
    notifyListeners();
  }

  void addAc(AcNilaiModel ac) {
    _listAc.add(ac);
    notifyListeners();
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

  void addEnvironment(EnvironmentModel env) {
    _listEnvironment.add(env);
    notifyListeners();
  }
}
