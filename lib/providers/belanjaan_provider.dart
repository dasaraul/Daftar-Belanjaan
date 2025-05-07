import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/belanjaan_model.dart';

class BelanjaanProvider with ChangeNotifier {
  List<BelanjaanModel> _daftarBelanjaan = [];
  final String _kunciStorage = 'daftar_belanjaan';
  final _uuid = const Uuid();
  bool _isLoading = false;

  List<BelanjaanModel> get daftarBelanjaan => [..._daftarBelanjaan];
  bool get isLoading => _isLoading;

  // Optimasi - Inisialisasi dan memuat data dari SharedPreferences
  BelanjaanProvider() {
    _muatDaftarBelanjaan();
  }

  // Memuat data dari penyimpanan lokal dengan performa yang dioptimalkan
  Future<void> _muatDaftarBelanjaan() async {
    try {
      _setLoading(true);
      
      final prefs = await SharedPreferences.getInstance();
      final stringData = prefs.getString(_kunciStorage);
      
      if (stringData != null) {
        // Konversi ke JSON dan inisialisasi secara efisien
        compute(_parseDaftarBelanjaan, stringData).then((value) {
          _daftarBelanjaan = value;
          _setLoading(false);
          notifyListeners();
        });
      } else {
        _setLoading(false);
      }
    } catch (e) {
      debugPrint('Error memuat data: $e');
      _setLoading(false);
    }
  }

  // Fungsi helper untuk parsing di isolate terpisah (meningkatkan performa)
  static List<BelanjaanModel> _parseDaftarBelanjaan(String stringData) {
    final List<dynamic> daftarJson = jsonDecode(stringData);
    return daftarJson
        .map((item) => BelanjaanModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  // Helper untuk mengatur status loading
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Menyimpan data ke penyimpanan lokal dengan performa yang dioptimalkan
  Future<void> _simpanDaftarBelanjaan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Konversi data ke JSON secara efisien
      final String jsonString = await compute(_serializeDaftarBelanjaan, _daftarBelanjaan);
      
      await prefs.setString(_kunciStorage, jsonString);
    } catch (e) {
      debugPrint('Error menyimpan data: $e');
    }
  }

  // Fungsi helper untuk serialisasi di isolate terpisah (meningkatkan performa)
  static String _serializeDaftarBelanjaan(List<BelanjaanModel> daftar) {
    final daftarJson = daftar.map((item) => item.toMap()).toList();
    return jsonEncode(daftarJson);
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