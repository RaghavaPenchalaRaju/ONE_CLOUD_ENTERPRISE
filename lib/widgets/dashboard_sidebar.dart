import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../routes/service_routes.dart';

class DashboardSidebar extends StatefulWidget {
  final String selectedPage;
  final bool expanded;
  final ValueChanged<String> onPageSelected;

  const DashboardSidebar({
    super.key,
    required this.selectedPage,
    required this.expanded,
    required this.onPageSelected,
  });

  @override
  State<DashboardSidebar> createState() => _DashboardSidebarState();
}

class _DashboardSidebarState extends State<DashboardSidebar> {
  final Set<String> expandedServices = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF151A23),
      child: SafeArea(
        child: Column(
          children: [
            _buildLogo(),

            const Divider(height: 1, color: Color(0xFF252C38)),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    _buildDashboardItem(),

                    const SizedBox(height: 10),

                    ...ServiceRoutes.groups.map(_buildServiceGroup),
                  ],
                ),
              ),
            ),

            _buildSignOut(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      height: 72,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.expanded ? 16 : 12),
        child: Row(
          children: [
            Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: const Color(0xFF26303D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.cloud_outlined,
                color: Color(0xFFCBD5E1),
                size: 22,
              ),
            ),

            if (widget.expanded) ...[
              const SizedBox(width: 11),
              const Expanded(
                child: Text(
                  'ONE CLOUD\nENTERPRISE PLATFORM',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xFFE5E7EB),
                    fontSize: 11,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem() {
    return _mainItem(
      icon: Icons.dashboard_outlined,
      title: 'Dashboard',
      selected: widget.selectedPage == 'Dashboard',
      onTap: () {
        widget.onPageSelected('Dashboard');
      },
    );
  }

  Widget _buildServiceGroup(ServiceGroup group) {
    final bool groupSelected = widget.selectedPage == group.title;

    final bool childSelected = group.items.any(
      (item) => item.title == widget.selectedPage,
    );

    final bool isOpen =
        widget.expanded && expandedServices.contains(group.title);

    return Column(
      children: [
        _mainItem(
          icon: group.icon,
          title: group.title,
          selected: groupSelected || childSelected,
          trailing: widget.expanded
              ? Icon(
                  isOpen
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: const Color(0xFF7F8A9D),
                  size: 19,
                )
              : null,
          onTap: () {
            if (!widget.expanded) {
              widget.onPageSelected(group.title);
              return;
            }

            setState(() {
              if (expandedServices.contains(group.title)) {
                expandedServices.remove(group.title);
              } else {
                expandedServices.add(group.title);
              }
            });

            widget.onPageSelected(group.title);
          },
        ),

        if (isOpen)
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 3),
            child: Column(
              children: group.items.map((item) {
                return _subItem(item, widget.selectedPage == item.title);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _mainItem({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 46,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: widget.expanded ? 11 : 0),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF273444) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: widget.expanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected
                    ? const Color(0xFFE5E7EB)
                    : const Color(0xFF9CA3AF),
                size: 20,
              ),

              if (widget.expanded) ...[
                const SizedBox(width: 11),

                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFFF3F4F6)
                          : const Color(0xFFC4CBD5),
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),

                if (trailing != null) trailing,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _subItem(ServiceItem item, bool selected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {
          widget.onPageSelected(item.title);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
          margin: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF222B38) : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                color: selected
                    ? const Color(0xFFDCE3EC)
                    : const Color(0xFF7F8A9D),
                size: 16,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFFE5E7EB)
                        : const Color(0xFFAEB7C5),
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignOut() {
    return Container(
      padding: EdgeInsets.all(widget.expanded ? 11 : 9),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF252C38))),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          },
          child: Container(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: widget.expanded ? 11 : 0),
            child: Row(
              mainAxisAlignment: widget.expanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Color(0xFFF87171), size: 20),

                if (widget.expanded) ...[
                  const SizedBox(width: 11),
                  const Expanded(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Color(0xFFF87171),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
