import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMenuTap;
  final bool sidebarExpanded;

  const DashboardHeader({
    super.key,
    required this.title,
    this.onMenuTap,
    this.sidebarExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onMenuTap,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    sidebarExpanded
                        ? Icons.menu_open_rounded
                        : Icons.menu_rounded,
                    color: const Color(0xFF172B4D),
                    size: 23,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              flex: 2,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF172B4D),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            if (MediaQuery.of(context).size.width > 900)
              Container(
                width: 360,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search services, modules...',
                    hintStyle: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 13,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),

            const SizedBox(width: 16),

            PopupMenuButton<String>(
              tooltip: 'Account',
              offset: const Offset(0, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 'profile') {
                  Navigator.pushNamed(context, AppRoutes.profile);
                }

                if (value == 'settings') {
                  Navigator.pushNamed(context, AppRoutes.settings);
                }

                if (value == 'signout') {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Color(0xFF374151),
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text('My Profile', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),

                  const PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF374151),
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text('Settings', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),

                  const PopupMenuDivider(),

                  const PopupMenuItem<String>(
                    value: 'signout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red, size: 20),
                        SizedBox(width: 12),
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'RP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (MediaQuery.of(context).size.width > 600)
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Raghava Penchalraju',
                            style: TextStyle(
                              color: Color(0xFF172B4D),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Administrator',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF6B7280),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
