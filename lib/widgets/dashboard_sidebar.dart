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
      color: const Color(0xFF151A23),
      child: Column(
        children: [
          _buildBrand(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: widget.expanded ? 12 : 8,
                vertical: 12,
              ),
              child: Column(
                children: [...ServiceRoutes.groups.map(_buildServiceGroup)],
              ),
            ),
          ),
          _buildSignOut(),
        ],
      ),
    );
  }

  Widget _buildBrand() {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: widget.expanded ? 16 : 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF29313D))),
      ),
      child: widget.expanded
          ? Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF60A5FA)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.cloud_outlined,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'ONE CLOUD\nENTERPRISE PLATFORM',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF60A5FA)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.cloud_outlined,
                  color: Colors.white,
                  size: 21,
                ),
              ),
            ),
    );
  }

  Widget _buildServiceGroup(ServiceGroup group) {
    final isSelected = widget.selectedPage == group.title;
    final isExpanded = expandedServices.contains(group.title);

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          _groupButton(
            group: group,
            selected: isSelected,
            expanded: isExpanded,
          ),
          if (widget.expanded && isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
              child: Column(children: group.items.map(_buildSubItem).toList()),
            ),
        ],
      ),
    );
  }

  Widget _groupButton({
    required ServiceGroup group,
    required bool selected,
    required bool expanded,
  }) {
    return Material(
      color: selected ? const Color(0xFF1E3A5F) : Colors.transparent,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: () {
          if (widget.expanded) {
            setState(() {
              if (expandedServices.contains(group.title)) {
                expandedServices.remove(group.title);
              } else {
                expandedServices.add(group.title);
              }
            });
          }

          widget.onPageSelected(group.title);
        },
        child: Container(
          height: 46,
          padding: EdgeInsets.symmetric(horizontal: widget.expanded ? 12 : 0),
          child: Row(
            mainAxisAlignment: widget.expanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(
                group.icon,
                size: 20,
                color: selected
                    ? const Color(0xFF60A5FA)
                    : const Color(0xFF94A3B8),
              ),
              if (widget.expanded) ...[
                const SizedBox(width: 11),
                Expanded(
                  child: Text(
                    group.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected ? Colors.white : const Color(0xFFD1D5DB),
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: const Color(0xFF64748B),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubItem(ServiceItem item) {
    final selected = widget.selectedPage == item.title;

    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Material(
        color: selected ? const Color(0xFF202B3B) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            widget.onPageSelected(item.title);
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 17,
                  color: selected
                      ? const Color(0xFF60A5FA)
                      : const Color(0xFF7F8A9A),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected ? Colors.white : const Color(0xFFB8C1CE),
                      fontSize: 10,
                      height: 1.25,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignOut() {
    return Container(
      padding: EdgeInsets.all(widget.expanded ? 12 : 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF29313D))),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          },
          child: Container(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: widget.expanded ? 12 : 0),
            child: Row(
              mainAxisAlignment: widget.expanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFF87171),
                  size: 19,
                ),
                if (widget.expanded) ...[
                  const SizedBox(width: 11),
                  const Expanded(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Color(0xFFE5E7EB),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
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
