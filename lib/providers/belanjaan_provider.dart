import 'package:flutter/material.dart';
import '../models/belanjaan_model.dart';

class BelanjaanProvider with ChangeNotifier {
  List<BelanjaanModel> _daftar = [];

  List<BelanjaanModel> get daftar => _daftar;

  void tambah(BelanjaanModel item) {
    _daftar.add(item);
    notifyListeners();
  }
}
