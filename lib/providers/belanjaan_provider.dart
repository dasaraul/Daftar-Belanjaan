import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/belanjaan_model.dart';

class BelanjaanProvider with ChangeNotifier {
  List<BelanjaanModel> _daftarBelanjaan = [];
  final String _kunciStorage = 'daftar_belanjaan';
  final _uuid = Uuid();

  List<BelanjaanModel> get daftarBelanjaan => [..._daftarBelanjaan];

  // Inisialisasi dan memuat data dari SharedPreferences
  BelanjaanProvider() {
    _muatDaftarBelanjaan();
  }

  // Memuat data dari penyimpanan lokal
  Future<void> _muatDaftarBelanjaan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stringData = prefs.getString(_kunciStorage);
      
      if (stringData != null) {
        final List<dynamic> daftarJson = jsonDecode(stringData);
        _daftarBelanjaan = daftarJson
            .map((item) => BelanjaanModel.fromMap(Map<String, dynamic>.from(item)))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error memuat data: $e');
    }
  }

  // Menyimpan data ke penyimpanan lokal
  Future<void> _simpanDaftarBelanjaan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final daftarJson = _daftarBelanjaan.map((item) => item.toMap()).toList();
      await prefs.setString(_kunciStorage, jsonEncode(daftarJson));
    } catch (e) {
      print('Error menyimpan data: $e');
    }
  }

  // Menambah item belanjaan baru
  Future<void> tambahBelanjaan(String nama, int jumlah, String catatan) async {
    final barangBaru = BelanjaanModel(
      id: _uuid.v4(),
      nama: nama,
      jumlah: jumlah,
      catatan: catatan,
    );
    
    _daftarBelanjaan.add(barangBaru);
    notifyListeners();
    await _simpanDaftarBelanjaan();
  }

  // Memperbarui/mengedit item belanjaan
  Future<void> updateBelanjaan(
      String id, String nama, int jumlah, String catatan) async {
    final index = _daftarBelanjaan.indexWhere((item) => item.id == id);
    
    if (index >= 0) {
      _daftarBelanjaan[index] = _daftarBelanjaan[index].copyWith(
        nama: nama,
        jumlah: jumlah,
        catatan: catatan,
      );
      notifyListeners();
      await _simpanDaftarBelanjaan();
    }
  }

  // Menghapus item belanjaan
  Future<void> hapusBelanjaan(String id) async {
    _daftarBelanjaan.removeWhere((item) => item.id == id);
    notifyListeners();
    await _simpanDaftarBelanjaan();
  }

  // Toggle status selesai/belum
  Future<void> toggleStatusBelanjaan(String id) async {
    final index = _daftarBelanjaan.indexWhere((item) => item.id == id);
    
    if (index >= 0) {
      _daftarBelanjaan[index] = _daftarBelanjaan[index].copyWith(
        selesai: !_daftarBelanjaan[index].selesai,
      );
      notifyListeners();
      await _simpanDaftarBelanjaan();
    }
  }
}