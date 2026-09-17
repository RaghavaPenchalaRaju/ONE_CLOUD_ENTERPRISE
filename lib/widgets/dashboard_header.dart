import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final VoidCallback onMenuTap;
  final VoidCallback onDashboardTap;
  final bool sidebarExpanded;

  const DashboardHeader({
    super.key,
    required this.title,
    required this.onMenuTap,
    required this.onDashboardTap,
    required this.sidebarExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            _buildMenuButton(),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ),
            if (width > 900) ...[_buildSearchBox(), const SizedBox(width: 14)],
            _buildDashboardButton(),
            const SizedBox(width: 10),
            _buildProfileMenu(context, width),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onMenuTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Icon(
            sidebarExpanded ? Icons.menu_open_rounded : Icons.menu_rounded,
            size: 21,
            color: const Color(0xFF374151),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      width: 270,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: const Row(
        children: [
          SizedBox(width: 13),
          Icon(Icons.search_rounded, size: 20, color: Color(0xFF6B7280)),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Search services, modules...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildDashboardButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onDashboardTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: const Icon(
            Icons.dashboard_rounded,
            size: 21,
            color: Color(0xFF2563EB),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, double width) {
    return PopupMenuButton<String>(
      tooltip: 'Account',
      offset: const Offset(0, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onSelected: (value) {
        if (value == 'profile') {
          Navigator.pushNamed(context, AppRoutes.profile);
        } else if (value == 'settings') {
          Navigator.pushNamed(context, AppRoutes.settings);
        } else if (value == 'logout') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
            value: 'profile',
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 19,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 11),
                const Text(
                  'My Profile',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'settings',
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 19,
                    color: Color(0xFF4B5563),
                  ),
                ),
                const SizedBox(width: 11),
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'logout',
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    size: 19,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(width: 11),
                const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFDC2626),
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      child: Container(
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: width > 600 ? 8 : 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Center(
                child: Text(
                  'RP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            if (width > 600) ...[
              const SizedBox(width: 9),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Raghava Penchalraju',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'Administrator',
                    style: TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: Color(0xFF6B7280),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
