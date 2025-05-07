class BelanjaanModel {
  final String id;
  final String nama;
  int jumlah;
  String catatan;
  bool selesai;

  BelanjaanModel({
    required this.id,
    required this.nama,
    this.jumlah = 1,
    this.catatan = '',
    this.selesai = false,
  });

  // Konversi dari Map ke BelanjaanModel (untuk membaca dari storage)
  factory BelanjaanModel.fromMap(Map<String, dynamic> map) {
    return BelanjaanModel(
      id: map['id'],
      nama: map['nama'],
      jumlah: map['jumlah'],
      catatan: map['catatan'],
      selesai: map['selesai'],
    );
  }

  // Konversi dari BelanjaanModel ke Map (untuk menyimpan ke storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jumlah': jumlah,
      'catatan': catatan,
      'selesai': selesai,
    };
  }

  // Membuat salinan dari objek dengan nilai yang diperbarui
  BelanjaanModel copyWith({
    String? id,
    String? nama,
    int? jumlah,
    String? catatan,
    bool? selesai,
  }) {
    return BelanjaanModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      jumlah: jumlah ?? this.jumlah,
      catatan: catatan ?? this.catatan,
      selesai: selesai ?? this.selesai,
    );
  }
}