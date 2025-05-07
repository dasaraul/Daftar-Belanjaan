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
                subtitle: Text('${belanjaan.daftar[i].jumlah} x $${belanjaan.daftar[i].harga}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
