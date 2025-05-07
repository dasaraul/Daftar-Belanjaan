import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/belanjaan_provider.dart';
import '../widgets/form_belanjaan.dart';
import '../widgets/layar_loading.dart';

class DaftarBelanjaanScreen extends StatefulWidget {
  const DaftarBelanjaanScreen({Key? key}) : super(key: key);

  @override
  State<DaftarBelanjaanScreen> createState() => _DaftarBelanjaanScreenState();
}

class _DaftarBelanjaanScreenState extends State<DaftarBelanjaanScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  // Fungsi untuk menampilkan toast dengan performa yang lebih baik
  void _tampilkanToast(String pesan, Color warna) {
    FToast fToast = FToast();
    fToast.init(context);
    
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: warna,
        boxShadow: [
          BoxShadow(
            color: warna.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            warna == Colors.green ? Icons.check_circle : 
            warna == Colors.blue ? Icons.edit : 
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(width: 12.0),
          Text(
            pesan,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
    
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          bottom: 50.0,
          left: 0.0,
          right: 0.0,
          child: child,
        );
      }
    );
  }

  // Fungsi untuk menambah barang belanjaan baru
  Future<void> _tambahBelanjaan(String nama, int jumlah, String catatan) async {
    setState(() => _isLoading = true);
    
    // Optimasi waktu loading
    await Future.delayed(const Duration(milliseconds: 500));
    
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .tambahBelanjaan(nama, jumlah, catatan);
    
    setState(() => _isLoading = false);
    
    _tampilkanToast("Berhasil menambah barang belanjaan", Colors.green);
  }

  // Fungsi untuk mengedit barang belanjaan
  Future<void> _editBelanjaan(String id, String nama, int jumlah, String catatan) async {
    setState(() => _isLoading = true);
    
    // Optimasi waktu loading
    await Future.delayed(const Duration(milliseconds: 500));
    
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .updateBelanjaan(id, nama, jumlah, catatan);
    
    setState(() => _isLoading = false);
    
    _tampilkanToast("Berhasil mengedit barang belanjaan", Colors.blue);
  }

  // Fungsi untuk menghapus barang belanjaan
  Future<void> _hapusBelanjaan(String id) async {
    setState(() => _isLoading = true);
    
    // Optimasi waktu loading
    await Future.delayed(const Duration(milliseconds: 500));
    
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .hapusBelanjaan(id);
    
    setState(() => _isLoading = false);
    
    _tampilkanToast("Berhasil menghapus barang belanjaan", Colors.red.shade400);
  }

  // Fungsi untuk toggle status belanjaan (selesai/belum)
  Future<void> _toggleStatusBelanjaan(String id) async {
    // Tidak perlu loading screen untuk toggle status
    await Provider.of<BelanjaanProvider>(context, listen: false)
        .toggleStatusBelanjaan(id);
  }

  @override
  Widget build(BuildContext context) {
    final daftarBelanjaan = Provider.of<BelanjaanProvider>(context).daftarBelanjaan;
    final theme = Theme.of(context);
    
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Daftar Belanjaan', 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: FadeTransition(
            opacity: _animation,
            child: daftarBelanjaan.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_basket_outlined,
                          size: 80,
                          color: theme.colorScheme.primary.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada barang belanjaan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            'Tambahkan barang belanjaan dengan tombol di bawah',
                            style: TextStyle(
                              color: theme.colorScheme.onBackground.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: daftarBelanjaan.length,
                    itemBuilder: (ctx, index) {
                      final item = daftarBelanjaan[index];
                      return Slidable(
                        key: ValueKey(item.id),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.45,
                          children: [
                            SlidableAction(
                              onPressed: (_) => _tampilkanFormEdit(
                                item.id,
                                item.nama,
                                item.jumlah,
                                item.catatan,
                              ),
                              backgroundColor: theme.colorScheme.secondary,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
                            ),
                            SlidableAction(
                              onPressed: (_) => _hapusBelanjaan(item.id),
                              backgroundColor: Colors.redAccent.shade100,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Hapus',
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
                            ),
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Checkbox(
                              value: item.selesai,
                              onChanged: (_) => _toggleStatusBelanjaan(item.id),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            title: Text(
                              item.nama,
                              style: TextStyle(
                                decoration: item.selesai
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                color: item.selesai 
                                    ? theme.colorScheme.onSurface.withOpacity(0.6)
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.numbers, 
                                      size: 14, 
                                      color: theme.colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Jumlah: ${item.jumlah}',
                                      style: TextStyle(
                                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                if (item.catatan.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.note, 
                                        size: 14, 
                                        color: theme.colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Catatan: ${item.catatan}',
                                          style: TextStyle(
                                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                            trailing: item.selesai
                                ? Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.secondary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: theme.colorScheme.secondary,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _tampilkanFormTambah,
            child: const Icon(Icons.add),
            tooltip: 'Tambah Barang',
            elevation: 4,
          ),
        ),
        if (_isLoading) const LayarLoading(),
      ],
    );
  }
}