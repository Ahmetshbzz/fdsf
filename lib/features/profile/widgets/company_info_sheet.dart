import 'package:flutter/material.dart';

class CompanyInfoSheet extends StatefulWidget {
  const CompanyInfoSheet({super.key});

  @override
  State<CompanyInfoSheet> createState() => _CompanyInfoSheetState();
}

class _CompanyInfoSheetState extends State<CompanyInfoSheet> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController(text: 'Ahmet Ltd. Şti.');
  final _taxNumberController = TextEditingController(text: '1234567890');
  final _taxOfficeController = TextEditingController(text: 'İstanbul');
  final _companyPhoneController =
      TextEditingController(text: '+90 212 123 4567');
  final _companyAddressController =
      TextEditingController(text: 'İstanbul, Türkiye');

  @override
  void dispose() {
    _companyNameController.dispose();
    _taxNumberController.dispose();
    _taxOfficeController.dispose();
    _companyPhoneController.dispose();
    _companyAddressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Burada API çağrısı yapılacak
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Şirket bilgileri kaydedildi')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Şirket Bilgileri',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _companyNameController,
                label: 'Şirket Adı',
                icon: Icons.business_center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şirket adı boş olamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _taxNumberController,
                label: 'Vergi No',
                icon: Icons.receipt,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vergi no boş olamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _taxOfficeController,
                label: 'Vergi Dairesi',
                icon: Icons.location_city,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vergi dairesi boş olamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _companyPhoneController,
                label: 'Şirket Telefonu',
                icon: Icons.phone_in_talk,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şirket telefonu boş olamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _companyAddressController,
                label: 'Şirket Adresi',
                icon: Icons.location_on,
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şirket adresi boş olamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Kaydet'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }
}
