import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/helpers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              // Profil fotoğrafı
              _buildProfileHeader(),
              const SizedBox(height: 24),
              // Profil bilgileri
              _buildProfileInfo(context),
              const SizedBox(height: 16),
              // Şirket bilgileri
              _buildCompanyInfo(context),
              const SizedBox(height: 16),
              // Ayarlar
              _buildSettings(context),
              const SizedBox(height: 24),
              // Çıkış butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Helpers.showSnackBar(context, 'Çıkış yapıldı');
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.logout, size: 18),
                  label:
                      const Text('Çıkış Yap', style: TextStyle(fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.blue.shade100,
          child: const Icon(
            Icons.person,
            size: 45,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Ahmet Toptancı',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'ahmet@toptanci.com',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified,
                size: 14,
                color: Colors.green.shade700,
              ),
              const SizedBox(width: 4),
              Text(
                'Onaylı Toptancı',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return _buildCard(
      context,
      title: 'Kişisel Bilgiler',
      icon: Icons.person,
      children: [
        _buildInfoRow(Icons.phone, 'Telefon', '+90 555 123 4567'),
        const Divider(height: 20),
        _buildInfoRow(Icons.email, 'E-posta', 'ahmet@toptanci.com'),
        const Divider(height: 20),
        _buildInfoRow(Icons.location_on, 'Adres', 'İstanbul, Türkiye'),
        const Divider(height: 20),
        _buildInfoRow(Icons.calendar_today, 'Üyelik Tarihi', '15.05.2023'),
      ],
    );
  }

  Widget _buildCompanyInfo(BuildContext context) {
    return _buildCard(
      context,
      title: 'Şirket Bilgileri',
      icon: Icons.business,
      children: [
        _buildInfoRow(
            Icons.business_center, 'Şirket Adı', 'Ahmet Toptancı Ltd. Şti.'),
        const Divider(height: 20),
        _buildInfoRow(Icons.receipt, 'Vergi No', '1234567890'),
        const Divider(height: 20),
        _buildInfoRow(Icons.location_city, 'Vergi Dairesi', 'İstanbul'),
        const Divider(height: 20),
        _buildInfoRow(
            Icons.phone_in_talk, 'Şirket Telefonu', '+90 212 123 4567'),
      ],
    );
  }

  Widget _buildSettings(BuildContext context) {
    return _buildCard(
      context,
      title: 'Ayarlar',
      icon: Icons.settings,
      children: [
        _buildSettingRow(
          context,
          icon: Icons.notifications,
          title: 'Bildirimler',
          hasSwitch: true,
        ),
        const Divider(height: 20),
        _buildSettingRow(
          context,
          icon: Icons.lock,
          title: 'Gizlilik',
          hasSwitch: false,
        ),
        const Divider(height: 20),
        _buildSettingRow(
          context,
          icon: Icons.language,
          title: 'Dil',
          hasSwitch: false,
        ),
        const Divider(height: 20),
        _buildSettingRow(
          context,
          icon: Icons.dark_mode,
          title: 'Karanlık Mod',
          hasSwitch: true,
          switchValue: false,
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 18,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool hasSwitch,
    bool switchValue = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        hasSwitch
            ? Switch(
                value: switchValue,
                onChanged: (value) {},
                activeColor: Theme.of(context).primaryColor,
              )
            : const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 18,
              ),
      ],
    );
  }
}
