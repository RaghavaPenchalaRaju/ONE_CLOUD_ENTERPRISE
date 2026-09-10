import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool emailNotifications = true;
  bool securityAlerts = true;
  bool cloudAlerts = true;
  bool twoStepAuthentication = true;
  bool autoRefresh = true;
  bool darkMode = false;

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved successfully'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF172B4D),
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF172B4D)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth < 600 ? 16 : 32,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),

                      _buildNotificationSection(),

                      const SizedBox(height: 20),

                      _buildSecuritySection(),

                      const SizedBox(height: 20),

                      _buildApplicationSection(),

                      const SizedBox(height: 28),

                      _buildSaveButton(),

                      const SizedBox(height: 30),

                      _buildAccountSection(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF172B4D), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.settings_outlined, color: Colors.white, size: 34),
          SizedBox(height: 12),
          Text(
            'Platform Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Manage your notifications, security and application preferences.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection() {
    return _settingsCard(
      title: 'Notifications',
      icon: Icons.notifications_none_outlined,
      children: [
        _settingTile(
          title: 'Email Notifications',
          subtitle: 'Receive important platform updates by email.',
          icon: Icons.email_outlined,
          value: emailNotifications,
          onChanged: (value) {
            setState(() {
              emailNotifications = value;
            });
          },
        ),
        _settingTile(
          title: 'Security Alerts',
          subtitle: 'Receive notifications about security events.',
          icon: Icons.security_outlined,
          value: securityAlerts,
          onChanged: (value) {
            setState(() {
              securityAlerts = value;
            });
          },
        ),
        _settingTile(
          title: 'Cloud Alerts',
          subtitle: 'Receive alerts about cloud infrastructure.',
          icon: Icons.cloud_outlined,
          value: cloudAlerts,
          onChanged: (value) {
            setState(() {
              cloudAlerts = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return _settingsCard(
      title: 'Security',
      icon: Icons.shield_outlined,
      children: [
        _settingTile(
          title: 'Two-Step Authentication',
          subtitle: 'Protect your account with OTP verification.',
          icon: Icons.verified_user_outlined,
          value: twoStepAuthentication,
          onChanged: (value) {
            setState(() {
              twoStepAuthentication = value;
            });
          },
        ),
        _actionTile(
          title: 'Change Password',
          subtitle: 'Update your account password.',
          icon: Icons.lock_outline,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.resetPassword);
          },
        ),
        _actionTile(
          title: 'Active Sessions',
          subtitle: 'Review your currently active sessions.',
          icon: Icons.devices_outlined,
          onTap: () {
            _showMessage('Active sessions: 3');
          },
        ),
      ],
    );
  }

  Widget _buildApplicationSection() {
    return _settingsCard(
      title: 'Application Preferences',
      icon: Icons.tune_outlined,
      children: [
        _settingTile(
          title: 'Auto Refresh',
          subtitle: 'Automatically refresh dashboard information.',
          icon: Icons.refresh_outlined,
          value: autoRefresh,
          onChanged: (value) {
            setState(() {
              autoRefresh = value;
            });
          },
        ),
        _settingTile(
          title: 'Dark Mode',
          subtitle: 'Use dark appearance for the application.',
          icon: Icons.dark_mode_outlined,
          value: darkMode,
          onChanged: (value) {
            setState(() {
              darkMode = value;
            });

            _showMessage(value ? 'Dark Mode enabled' : 'Dark Mode disabled');
          },
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_circle_outlined, color: Color(0xFF2563EB)),
              SizedBox(width: 10),
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172B4D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _accountRow('Account Type', 'Enterprise'),
          _accountRow('Role', 'Administrator'),
          _accountRow('Status', 'Active'),
          _accountRow('Platform', 'ONE CLOUD ENTERPRISE PLATFORM'),
        ],
      ),
    );
  }

  Widget _accountRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF172B4D),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF2563EB), size: 23),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172B4D),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          ...children,
        ],
      ),
    );
  }

  Widget _settingTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF2563EB)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _actionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF374151)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF172B4D),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: _saveSettings,
        icon: const Icon(Icons.save_outlined),
        label: const Text(
          'Save Settings',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
