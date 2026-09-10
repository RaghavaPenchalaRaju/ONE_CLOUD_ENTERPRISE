import 'package:flutter/material.dart';

import '../services/service_content_page.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_sidebar.dart';
import '../widgets/stat_card.dart';

class DashboardPage extends StatefulWidget {
  final String? initialPage;

  const DashboardPage({super.key, this.initialPage});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const String dashboardTitle = 'Dashboard';

  late String selectedPage;

  bool sidebarExpanded = true;

  @override
  void initState() {
    super.initState();

    selectedPage = widget.initialPage ?? dashboardTitle;
  }

  void _selectPage(String page) {
    setState(() {
      selectedPage = page;
    });
  }

  void _toggleSidebar() {
    setState(() {
      sidebarExpanded = !sidebarExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 850) {
            return _buildMobile();
          }

          return _buildDesktop();
        },
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: sidebarExpanded ? 286 : 72,
          child: DashboardSidebar(
            selectedPage: selectedPage,
            expanded: sidebarExpanded,
            onPageSelected: _selectPage,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              DashboardHeader(
                title: selectedPage,
                sidebarExpanded: sidebarExpanded,
                onMenuTap: _toggleSidebar,
              ),
              Expanded(child: _buildContent()),
              const DashboardFooter(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      drawer: Drawer(
        width: 300,
        child: DashboardSidebar(
          selectedPage: selectedPage,
          expanded: true,
          onPageSelected: (page) {
            Navigator.pop(context);
            _selectPage(page);
          },
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                DashboardHeader(
                  title: selectedPage,
                  sidebarExpanded: true,
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Expanded(child: _buildContent()),
                const DashboardFooter(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (selectedPage != dashboardTitle) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: ServiceContentPage(page: selectedPage),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: _dashboard(),
    );
  }

  Widget _dashboard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        final double gap = width >= 1200
            ? 20.0
            : width >= 700
            ? 16.0
            : 12.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcome(),

            SizedBox(height: gap),

            _kpis(width),

            SizedBox(height: gap),

            _serviceHealth(width),

            SizedBox(height: gap),

            _infrastructure(width),

            SizedBox(height: gap),

            _resourceUsage(width),

            SizedBox(height: gap),

            _businessOverview(width),

            SizedBox(height: gap),

            _securityAndAlerts(width),

            SizedBox(height: gap),

            _operations(width),

            SizedBox(height: gap),

            _recentActivity(),

            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  Widget _welcome() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF172B4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _welcomeText(),
                const SizedBox(height: 18),
                _operationalBadge(),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _welcomeText()),
              _operationalBadge(),
            ],
          );
        },
      ),
    );
  }

  Widget _welcomeText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good afternoon, Raghava',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 7),
        Text(
          'Enterprise platform overview and operational status.',
          style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
        ),
      ],
    );
  }

  Widget _operationalBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Color(0xFF86EFAC), size: 17),
          SizedBox(width: 7),
          Text(
            'All systems operational',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kpis(double width) {
    final int columns = width >= 1200
        ? 4
        : width >= 700
        ? 2
        : 1;

    final double spacing = width >= 1200
        ? 18.0
        : width >= 700
        ? 16.0
        : 12.0;

    return _grid(
      columns: columns,
      spacing: spacing,
      items: const [
        StatCard(
          title: 'Service Domains',
          value: '11',
          subtitle: '+2 this quarter',
          icon: Icons.apps_outlined,
        ),
        StatCard(
          title: 'Active Modules',
          value: '94',
          subtitle: '+8 this month',
          icon: Icons.grid_view_outlined,
        ),
        StatCard(
          title: 'Active Users',
          value: '1,248',
          subtitle: '+12.6% this month',
          icon: Icons.people_outline,
        ),
        StatCard(
          title: 'Platform Uptime',
          value: '99.99%',
          subtitle: 'Excellent availability',
          icon: Icons.speed_outlined,
        ),
      ],
    );
  }

  // ============================================================
  // SERVICE HEALTH
  // ============================================================

  Widget _serviceHealth(double width) {
    return _card(
      title: 'Service Health',
      subtitle: 'Operational status across enterprise domains',
      icon: Icons.monitor_heart_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 600
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12.0,
            items: [
              _health('Platform Administration'),
              _health('HRMS'),
              _health('CRM'),
              _health('ERP'),
              _health('Finance & Accounting'),
              _health('Workflow & Automation'),
              _health('Documentation'),
              _health('Subscription'),
              _health('Revenue'),
              _health('Monitoring'),
              _health('Storage'),
            ],
          );
        },
      ),
    );
  }

  Widget _health(String title) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF16A34A),
            size: 18,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(
            'Healthy',
            style: TextStyle(
              color: Color(0xFF15803D),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infrastructure(double width) {
    return _card(
      title: 'Cloud Infrastructure',
      subtitle: 'Current infrastructure resources',
      icon: Icons.cloud_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int columns = constraints.maxWidth >= 1000
              ? 3
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 14.0,
            items: [
              _infra(Icons.dns_outlined, 'Kubernetes', '3', 'Clusters'),
              _infra(Icons.functions_outlined, 'Serverless', '28', 'Functions'),
              _infra(
                Icons.account_tree_outlined,
                'Load Balancers',
                '6',
                'Active',
              ),
              _infra(Icons.public_outlined, 'CDN Zones', '14', 'Configured'),
              _infra(Icons.language_outlined, 'DNS Domains', '32', 'Managed'),
              _infra(Icons.lan_outlined, 'Networks', '8', 'Connected'),
            ],
          );
        },
      ),
    );
  }

  Widget _infra(IconData icon, String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xFF172B4D),
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _resourceUsage(double width) {
    return _card(
      title: 'Resource Utilization',
      subtitle: 'Current capacity and consumption',
      icon: Icons.bar_chart_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Column(
              children: [
                _usage('Storage', .68, '68%'),
                const SizedBox(height: 16),
                _usage('Compute', .54, '54%'),
                const SizedBox(height: 16),
                _usage('Network', .41, '41%'),
                const SizedBox(height: 16),
                _usage('Database', .73, '73%'),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _usage('Storage', .68, '68%')),
              const SizedBox(width: 20),
              Expanded(child: _usage('Compute', .54, '54%')),
              const SizedBox(width: 20),
              Expanded(child: _usage('Network', .41, '41%')),
              const SizedBox(width: 20),
              Expanded(child: _usage('Database', .73, '73%')),
            ],
          );
        },
      ),
    );
  }

  Widget _usage(String title, double value, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF172B4D),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF64748B)),
          ),
        ),
      ],
    );
  }

  Widget _businessOverview(double width) {
    return _card(
      title: 'Business Overview',
      subtitle: 'Key enterprise business metrics',
      icon: Icons.analytics_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 600
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12.0,
            items: [
              _business(
                'Monthly Revenue',
                '₹24.8M',
                '+8.4%',
                Icons.payments_outlined,
              ),
              _business(
                'Open Opportunities',
                '186',
                '+14.2%',
                Icons.trending_up_outlined,
              ),
              _business(
                'Pending Approvals',
                '42',
                '-6.8%',
                Icons.approval_outlined,
              ),
              _business(
                'Active Contracts',
                '328',
                '+4.7%',
                Icons.description_outlined,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _business(String title, String value, String change, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 22),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  change,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _securityAndAlerts(double width) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [_security(), const SizedBox(height: 16), _alerts()],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _security()),
            const SizedBox(width: 16),
            Expanded(child: _alerts()),
          ],
        );
      },
    );
  }

  Widget _security() {
    return _card(
      title: 'Security Posture',
      subtitle: 'Enterprise security controls',
      icon: Icons.shield_outlined,
      child: Column(
        children: [
          _securityRow(Icons.security_outlined, 'Firewall', 'Protected'),
          _securityRow(Icons.gpp_maybe_outlined, 'Threat Detection', 'Active'),
          _securityRow(Icons.lock_outline, 'Encryption', 'Enabled'),
          _securityRow(
            Icons.verified_user_outlined,
            'Two-Step Authentication',
            'Enabled',
          ),
          _securityRow(
            Icons.manage_accounts_outlined,
            'Access Control',
            'Healthy',
          ),
        ],
      ),
    );
  }

  Widget _securityRow(IconData icon, String title, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              color: Color(0xFF15803D),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _alerts() {
    return _card(
      title: 'Alerts & Notifications',
      subtitle: 'Current items requiring attention',
      icon: Icons.notifications_none_outlined,
      child: Column(
        children: [
          _alert(
            Icons.warning_amber_outlined,
            'Storage capacity',
            'Storage utilization has reached 68%.',
            'Review',
          ),
          _alert(
            Icons.info_outline,
            'Platform update',
            'A new platform version is available.',
            'Info',
          ),
          _alert(
            Icons.check_circle_outline,
            'Security scan',
            'No critical security issues detected.',
            'Done',
          ),
          _alert(
            Icons.backup_outlined,
            'Backup completed',
            'Scheduled backup completed successfully.',
            'Done',
          ),
        ],
      ),
    );
  }

  Widget _alert(IconData icon, String title, String subtitle, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _operations(double width) {
    return _card(
      title: 'Operations',
      subtitle: 'Deployments, databases, APIs and backups',
      icon: Icons.settings_suggest_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 600
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12.0,
            items: [
              _operation(
                Icons.rocket_launch_outlined,
                'Deployments',
                '8',
                'Successful',
              ),
              _operation(Icons.storage_outlined, 'Databases', '24', 'Healthy'),
              _operation(Icons.api_outlined, 'API Requests', '2.4M', 'Today'),
              _operation(Icons.backup_outlined, 'Backups', '100%', 'Completed'),
            ],
          );
        },
      ),
    );
  }

  Widget _operation(
    IconData icon,
    String title,
    String value,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentActivity() {
    return _card(
      title: 'Recent Activity',
      subtitle: 'Latest events across your platform',
      icon: Icons.history_outlined,
      child: Column(
        children: [
          _activity(
            Icons.login_outlined,
            'Administrator signed in',
            'Successful authentication',
            'Just now',
          ),
          _divider(),
          _activity(
            Icons.cloud_done_outlined,
            'Infrastructure health check',
            'All cloud resources are operational',
            '12 min ago',
          ),
          _divider(),
          _activity(
            Icons.security_outlined,
            'Security scan completed',
            'No critical threats detected',
            '32 min ago',
          ),
          _divider(),
          _activity(
            Icons.people_outline,
            'Access review completed',
            'User permissions reviewed successfully',
            '1 hour ago',
          ),
          _divider(),
          _activity(
            Icons.settings_outlined,
            'Platform configuration updated',
            'Enterprise configuration synchronized',
            '2 hours ago',
          ),
          _divider(),
          _activity(
            Icons.backup_outlined,
            'Backup completed',
            'Scheduled enterprise backup completed',
            '3 hours ago',
          ),
        ],
      ),
    );
  }

  Widget _activity(IconData icon, String title, String subtitle, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: const Color(0xFF64748B), size: 19),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, color: Color(0xFFE5E7EB));
  }

  Widget _card({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 39,
                height: 39,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: const Color(0xFF64748B), size: 20),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF172B4D),
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          child,
        ],
      ),
    );
  }

  Widget _grid({
    required List<Widget> items,
    required int columns,
    required double spacing,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items.map((item) {
            return SizedBox(width: itemWidth, child: item);
          }).toList(),
        );
      },
    );
  }
}
