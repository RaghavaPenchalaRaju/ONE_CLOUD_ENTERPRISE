import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172B4D),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              children: [
                _profileBanner(),
                const SizedBox(height: 20),
                _section('Personal Information', Icons.person_outline, [
                  _info('Full Name', 'Raghava Penchalraju'),
                  _info('Email', 'raghavapenchalraju@thestackly.com'),
                  _info('Role', 'Administrator'),
                ]),
                const SizedBox(height: 18),
                _section('Account', Icons.business_outlined, [
                  _info('Account Type', 'Enterprise Cloud'),
                  _info('Plan', 'Enterprise'),
                  _info('Status', 'Active'),
                ]),
                const SizedBox(height: 18),
                _section('Security', Icons.security_outlined, [
                  _info('Two-Step Authentication', 'Enabled'),
                  _info('Last Password Change', 'Recently updated'),
                  _info('Active Sessions', '3 Sessions'),
                ]),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.settings);
                        },
                        icon: const Icon(Icons.settings_outlined),
                        label: const Text('Settings'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.login,
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout_outlined),
                        label: const Text('Sign Out'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF172B4D), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: Colors.white,
            child: Text(
              'RP',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Raghava Penchalraju',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Administrator',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _section(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2563EB)),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF172B4D),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
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

  Widget _info(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF172B4D),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
