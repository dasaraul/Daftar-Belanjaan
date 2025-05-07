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

class _FormBelanjaanState extends State<FormBelanjaan> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _catatanController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Animasi untuk form
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuint,
    );
    _animationController.forward();
    
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
    _animationController.dispose();
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
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return FractionallySizedBox(
          heightFactor: 0.6 * _animation.value,
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withAlpha(38), // 0.15 opacity = 38/255
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withAlpha(51), // 0.2 opacity = 51/255
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Header
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, color: theme.colorScheme.primary),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Text(
                            widget.judul,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.check, color: theme.colorScheme.primary),
                          onPressed: _simpanForm,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Form fields
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Field Nama Barang
                            Text(
                              'Nama Barang',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _namaController,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan nama barang belanjaan',
                                prefixIcon: Icon(Icons.shopping_bag_outlined),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Nama barang tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            
                            // Field Jumlah
                            Text(
                              'Jumlah',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _jumlahController,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan jumlah barang',
                                prefixIcon: Icon(Icons.numbers_outlined),
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
                            const SizedBox(height: 20),
                            
                            // Field Catatan
                            Text(
                              'Catatan (Opsional)',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _catatanController,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan catatan tambahan',
                                prefixIcon: Icon(Icons.note_outlined),
                              ),
                              maxLines: 3,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Button Simpan
                    ElevatedButton(
                      onPressed: _simpanForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: Colors.white,
                        backgroundColor: theme.colorScheme.secondary,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: const Text(
                        'SIMPAN',
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}