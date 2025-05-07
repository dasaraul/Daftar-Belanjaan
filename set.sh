#!/bin/bash

# Buat folder
mkdir -p lib/models
mkdir -p lib/providers
mkdir -p lib/screens
mkdir -p lib/widgets

# Buat file dan isi template dasar
cat > lib/models/belanjaan_model.dart <<EOF
class BelanjaanModel {
  final String nama;
  final int jumlah;
  final double harga;

  BelanjaanModel({
    required this.nama,
    required this.jumlah,
    required this.harga,
  });
}
EOF

cat > lib/providers/belanjaan_provider.dart <<EOF
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
EOF

cat > lib/screens/daftar_belanjaan_screen.dart <<EOF
import 'package:flutter/material.dart';
import '../providers/belanjaan_provider.dart';
import '../widgets/form_belanjaan.dart';
import '../widgets/layar_loading.dart';
import 'package:provider/provider.dart';

class DaftarBelanjaanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final belanjaan = Provider.of<BelanjaanProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Belanjaan')),
      body: Column(
        children: [
          FormBelanjaan(),
          Expanded(
            child: ListView.builder(
              itemCount: belanjaan.daftar.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(belanjaan.daftar[i].nama),
                subtitle: Text('\${belanjaan.daftar[i].jumlah} x \$\${belanjaan.daftar[i].harga}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
EOF

cat > lib/widgets/form_belanjaan.dart <<EOF
import 'package:flutter/material.dart';

class FormBelanjaan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text('Form input belanjaan di sini'),
      ),
    );
  }
}
EOF

cat > lib/widgets/layar_loading.dart <<EOF
import 'package:flutter/material.dart';

class LayarLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
EOF
