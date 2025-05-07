import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormBelanjaan extends StatefulWidget {
  final Function(String, int, String) onSimpan;
  final String judul;
  final String? namaAwal;
  final int? jumlahAwal;
  final String? catatanAwal;

  const FormBelanjaan({
    Key? key,
    required this.onSimpan,
    required this.judul,
    this.namaAwal,
    this.jumlahAwal,
    this.catatanAwal,
  }) : super(key: key);

  @override
  State<FormBelanjaan> createState() => _FormBelanjaanState();
}

class _FormBelanjaanState extends State<FormBelanjaan> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _catatanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Isi nilai awal jika ada (untuk edit)
    if (widget.namaAwal != null) {
      _namaController.text = widget.namaAwal!;
    }
    if (widget.jumlahAwal != null) {
      _jumlahController.text = widget.jumlahAwal.toString();
    } else {
      _jumlahController.text = '1'; // Default jumlah
    }
    if (widget.catatanAwal != null) {
      _catatanController.text = widget.catatanAwal!;
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _simpanForm() {
    if (_formKey.currentState!.validate()) {
      int jumlah = int.tryParse(_jumlahController.text) ?? 1;
      widget.onSimpan(
        _namaController.text.trim(),
        jumlah,
        _catatanController.text.trim(),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Text(
                      widget.judul,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: _simpanForm,
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  hintText: 'Masukkan nama barang belanjaan',
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _jumlahController,
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  hintText: 'Masukkan jumlah barang',
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah tidak boleh kosong';
                  }
                  int? jumlah = int.tryParse(value);
                  if (jumlah == null || jumlah <= 0) {
                    return 'Jumlah harus lebih dari 0';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _catatanController,
                decoration: InputDecoration(
                  labelText: 'Catatan (Opsional)',
                  hintText: 'Masukkan catatan tambahan',
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpanForm,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'SIMPAN',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}