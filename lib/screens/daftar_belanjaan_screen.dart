import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dotlottie_flutter/dotlottie.dart';

import '../providers/belanjaan_provider.dart';
import '../widgets/form_belanjaan.dart';
import '../widgets/layar_loading.dart';

class DaftarBelanjaanScreen extends StatefulWidget {
  const DaftarBelanjaanScreen({Key? key}) : super(key: key);

  @override
  State<DaftarBelanjaanScreen> createState() => _DaftarBelanjaanScreenState();
}

class _DaftarBelanjaanScreenState extends State<DaftarBelanjaanScreen> {
  bool _isLoading = false;

  void _tampilkanFormTambah() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FormBelanjaan(
        onSimpan: _tambahBelanjaan,
        judul: 'Tambah Barang Belanjaan',
      ),
    );
  }

  void _tampilkanFormEdit(String id, String nama, int jumlah, String catatan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FormBelanjaan(
        onSimpan: (nama, jumlah, catatan) => _editBelanjaan(id, nama, jumlah, catatan),
        judul: 'Edit Barang Belanjaan',
        namaAwal: nama,
        jumlahAwal: jumlah,
        catatanAwal: catatan,
      ),
    );
  }

  // Fungsi untuk menambah barang belanjaan baru
  Future<void> _tambahBelanjaan(String nama, int jumlah, String catatan) async {
    setState(() => _isLoading = true);
    
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading
    
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .tambahBelanjaan(nama, jumlah, catatan);
    
    setState(() => _isLoading = false);
    
    Fluttertoast.showToast(
      msg: "Berhasil menambah barang belanjaan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  // Fungsi untuk mengedit barang belanjaan
  Future<void> _editBelanjaan(String id, String nama, int jumlah, String catatan) async {
    setState(() => _isLoading = true);
    
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading
    
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .updateBelanjaan(id, nama, jumlah, catatan);
    
    setState(() => _isLoading = false);
    
    Fluttertoast.showToast(
      msg: "Berhasil mengedit barang belanjaan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  // Fungsi untuk menghapus barang belanjaan
  Future<void> _hapusBelanjaan(String id) async {
    setState(() => _isLoading = true);
    
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading
    
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .hapusBelanjaan(id);
    
    setState(() => _isLoading = false);
    
    Fluttertoast.showToast(
      msg: "Berhasil menghapus barang belanjaan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  // Fungsi untuk toggle status belanjaan (selesai/belum)
  Future<void> _toggleStatusBelanjaan(String id) async {
    setState(() => _isLoading = true);
    
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading
    
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .toggleStatusBelanjaan(id);
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final daftarBelanjaan = Provider.of<BelanjaanProvider>(context).daftarBelanjaan;
    
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Daftar Belanjaan'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Creator: Abdul Rahman',
                      style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: daftarBelanjaan.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Belum ada barang belanjaan',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tambahkan barang belanjaan dengan tombol di bawah',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: daftarBelanjaan.length,
                  itemBuilder: (ctx, index) {
                    final item = daftarBelanjaan[index];
                    return Slidable(
                      key: ValueKey(item.id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => _tampilkanFormEdit(
                              item.id,
                              item.nama,
                              item.jumlah,
                              item.catatan,
                            ),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (_) => _hapusBelanjaan(item.id),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Hapus',
                          ),
                        ],
                      ),
                      child: Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: item.selesai,
                            onChanged: (_) => _toggleStatusBelanjaan(item.id),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                            item.nama,
                            style: TextStyle(
                              decoration: item.selesai
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jumlah: ${item.jumlah}'),
                              if (item.catatan.isNotEmpty)
                                Text('Catatan: ${item.catatan}'),
                            ],
                          ),
                          trailing: item.selesai
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: _tampilkanFormTambah,
            child: const Icon(Icons.add),
            tooltip: 'Tambah Barang',
          ),
        ),
        if (_isLoading) const LayarLoading(),
      ],
    );
  }
}