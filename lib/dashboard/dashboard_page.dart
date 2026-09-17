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
      backgroundColor: const Color(0xFFF5F7FA),
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
                onDashboardTap: () {
                  _selectPage(dashboardTitle);
                },
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
      backgroundColor: const Color(0xFFF5F7FA),
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
                  onDashboardTap: () {
                    _selectPage(dashboardTitle);
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
        final width = constraints.maxWidth;
        final gap = width >= 1200
            ? 20.0
            : width >= 700
            ? 16.0
            : 12.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcome(),
            SizedBox(height: gap),
            _platformSummary(width),
            SizedBox(height: gap),
            _kpis(width),
            SizedBox(height: gap),
            _cloudProviders(width),
            SizedBox(height: gap),
            _serviceHealth(width),
            SizedBox(height: gap),
            _infrastructure(width),
            SizedBox(height: gap),
            _resourceUsage(width),
            SizedBox(height: gap),
            _performance(width),
            SizedBox(height: gap),
            _businessOverview(width),
            SizedBox(height: gap),
            _costManagement(width),
            SizedBox(height: gap),
            _securityAndCompliance(width),
            SizedBox(height: gap),
            _networkOverview(width),
            SizedBox(height: gap),
            _deploymentOverview(width),
            SizedBox(height: gap),
            _backupAndRecovery(width),
            SizedBox(height: gap),
            _regionalInfrastructure(width),
            SizedBox(height: gap),
            _alertsAndIncidents(width),
            SizedBox(height: gap),
            _operations(width),
            SizedBox(height: gap),
            _recentActivity(),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _welcome() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF172B4D), Color(0xFF243B64)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172B4D).withOpacity(.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _welcomeText(),
                const SizedBox(height: 20),
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
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Enterprise cloud platform control center',
          style: TextStyle(
            color: Color(0xFFD5DEEA),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Monitor infrastructure, applications, security, performance and business operations from one unified workspace.',
          style: TextStyle(color: Color(0xFFB9C7D9), fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  Widget _operationalBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E334F),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFF3B516E)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Color(0xFF86EFAC), size: 18),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All systems operational',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '99.99% platform availability',
                style: TextStyle(color: Color(0xFFAFC0D3), fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _platformSummary(double width) {
    return _card(
      title: 'Cloud Platform Overview',
      subtitle: 'Unified visibility across enterprise cloud environments',
      icon: Icons.cloud_queue_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
            items: [
              _summaryTile(
                Icons.cloud_done_outlined,
                'Production',
                'Healthy',
                '42 services',
                const Color(0xFF15803D),
              ),
              _summaryTile(
                Icons.cloud_outlined,
                'Staging',
                'Healthy',
                '28 services',
                const Color(0xFF15803D),
              ),
              _summaryTile(
                Icons.developer_mode_outlined,
                'Development',
                'Healthy',
                '36 services',
                const Color(0xFF15803D),
              ),
              _summaryTile(
                Icons.public_outlined,
                'Regions',
                'Active',
                '8 regions',
                const Color(0xFF2563EB),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryTile(
    IconData icon,
    String title,
    String status,
    String value,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF475569), size: 21),
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
                    color: Color(0xFF475569),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
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

  Widget _kpis(double width) {
    final columns = width >= 1200
        ? 4
        : width >= 700
        ? 2
        : 1;

    return _grid(
      columns: columns,
      spacing: 14,
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

  Widget _cloudProviders(double width) {
    return _card(
      title: 'Cloud Providers',
      subtitle: 'Enterprise cloud services and provider health',
      icon: Icons.cloud_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 3
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 14,
            items: [
              _provider(
                'AWS',
                'Amazon Web Services',
                '24',
                'Resources',
                Icons.cloud_outlined,
                'Healthy',
              ),
              _provider(
                'Azure',
                'Microsoft Azure',
                '18',
                'Resources',
                Icons.cloud_queue_outlined,
                'Healthy',
              ),
              _provider(
                'GCP',
                'Google Cloud Platform',
                '16',
                'Resources',
                Icons.public_outlined,
                'Healthy',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _provider(
    String name,
    String subtitle,
    String value,
    String metric,
    IconData icon,
    String status,
  ) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF334155), size: 23),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xFF172B4D),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      metric,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceHealth(double width) {
    return _card(
      title: 'Service Health',
      subtitle: 'Operational status across enterprise domains',
      icon: Icons.monitor_heart_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 600
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
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
              _health('Identity & Access'),
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(
            'Healthy',
            style: TextStyle(
              color: Color(0xFF15803D),
              fontSize: 9,
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
      subtitle: 'Compute, containers, networking and platform resources',
      icon: Icons.dns_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 3
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 14,
            items: [
              _infra(Icons.dns_outlined, 'Kubernetes', '3', 'Clusters'),
              _infra(Icons.view_in_ar_outlined, 'Containers', '186', 'Running'),
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
              _infra(Icons.storage_outlined, 'Databases', '24', 'Healthy'),
              _infra(Icons.memory_outlined, 'Compute Nodes', '72', 'Online'),
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 23),
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
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                    Flexible(
                      child: Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 10,
                        ),
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
      subtitle: 'Current capacity and consumption across cloud resources',
      icon: Icons.bar_chart_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Column(
              children: [
                _usage('Storage', .68, '68%', '2.7 TB / 4 TB'),
                const SizedBox(height: 17),
                _usage('Compute', .54, '54%', '38 / 72 nodes'),
                const SizedBox(height: 17),
                _usage('Network', .41, '41%', '4.1 TB / 10 TB'),
                const SizedBox(height: 17),
                _usage('Database', .73, '73%', '17.5 TB / 24 TB'),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _usage('Storage', .68, '68%', '2.7 TB / 4 TB')),
              const SizedBox(width: 20),
              Expanded(child: _usage('Compute', .54, '54%', '38 / 72 nodes')),
              const SizedBox(width: 20),
              Expanded(child: _usage('Network', .41, '41%', '4.1 TB / 10 TB')),
              const SizedBox(width: 20),
              Expanded(
                child: _usage('Database', .73, '73%', '17.5 TB / 24 TB'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _usage(String title, double value, String text, String detail) {
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
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF475569)),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          detail,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9),
        ),
      ],
    );
  }

  Widget _performance(double width) {
    return _card(
      title: 'Platform Performance',
      subtitle: 'Application latency, throughput and reliability indicators',
      icon: Icons.speed_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
            items: [
              _performanceTile(
                'API Latency',
                '124 ms',
                '↓ 8.2%',
                Icons.speed_outlined,
              ),
              _performanceTile('Requests', '2.4M', 'Today', Icons.api_outlined),
              _performanceTile(
                'Error Rate',
                '0.08%',
                '↓ 0.03%',
                Icons.error_outline,
              ),
              _performanceTile(
                'Response SLA',
                '99.97%',
                'Excellent',
                Icons.verified_outlined,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _performanceTile(
    String title,
    String value,
    String change,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  change,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 9,
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

  Widget _businessOverview(double width) {
    return _card(
      title: 'Business Overview',
      subtitle: 'Key enterprise business metrics',
      icon: Icons.analytics_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 600
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  change,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 9,
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

  Widget _costManagement(double width) {
    return _card(
      title: 'Cloud Cost Management',
      subtitle: 'Current month spend, budgets and optimization indicators',
      icon: Icons.account_balance_wallet_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return Column(
              children: [
                _costItem(
                  'Current Spend',
                  '₹8.42M',
                  '68% of monthly budget',
                  .68,
                ),
                const SizedBox(height: 18),
                _costItem('Compute Spend', '₹3.18M', '38% of total spend', .38),
                const SizedBox(height: 18),
                _costItem('Storage Spend', '₹1.46M', '17% of total spend', .17),
                const SizedBox(height: 18),
                _costItem('Network Spend', '₹920K', '11% of total spend', .11),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _costItem(
                  'Current Spend',
                  '₹8.42M',
                  '68% of monthly budget',
                  .68,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _costItem(
                  'Compute Spend',
                  '₹3.18M',
                  '38% of total spend',
                  .38,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _costItem(
                  'Storage Spend',
                  '₹1.46M',
                  '17% of total spend',
                  .17,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _costItem(
                  'Network Spend',
                  '₹920K',
                  '11% of total spend',
                  .11,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _costItem(
    String title,
    String value,
    String subtitle,
    double progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF172B4D),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF64748B),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _securityAndCompliance(double width) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [_security(), const SizedBox(height: 16), _compliance()],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _security()),
            const SizedBox(width: 16),
            Expanded(child: _compliance()),
          ],
        );
      },
    );
  }

  Widget _security() {
    return _card(
      title: 'Security Posture',
      subtitle: 'Enterprise security controls and identity protection',
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
          _securityRow(Icons.key_outlined, 'Key Management', 'Healthy'),
        ],
      ),
    );
  }

  Widget _compliance() {
    return _card(
      title: 'Compliance',
      subtitle: 'Governance and regulatory control status',
      icon: Icons.fact_check_outlined,
      child: Column(
        children: [
          _securityRow(Icons.verified_outlined, 'ISO 27001', 'Compliant'),
          _securityRow(Icons.verified_outlined, 'SOC 2', 'Compliant'),
          _securityRow(Icons.verified_outlined, 'GDPR Controls', 'Healthy'),
          _securityRow(Icons.verified_outlined, 'Data Protection', 'Enabled'),
          _securityRow(Icons.policy_outlined, 'Security Policies', '98%'),
          _securityRow(
            Icons.assignment_turned_in_outlined,
            'Audit Readiness',
            '96%',
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
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              color: Color(0xFF15803D),
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _networkOverview(double width) {
    return _card(
      title: 'Network & Connectivity',
      subtitle: 'Global network traffic, gateways and connectivity',
      icon: Icons.hub_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
            items: [
              _networkItem(
                'Ingress Traffic',
                '4.8 TB',
                '+12.4%',
                Icons.download_outlined,
              ),
              _networkItem(
                'Egress Traffic',
                '3.2 TB',
                '+8.7%',
                Icons.upload_outlined,
              ),
              _networkItem('API Gateway', '18', 'Healthy', Icons.api_outlined),
              _networkItem(
                'VPN Connections',
                '126',
                'Active',
                Icons.vpn_lock_outlined,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _networkItem(
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 9,
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

  Widget _deploymentOverview(double width) {
    return _card(
      title: 'DevOps & Deployments',
      subtitle: 'Continuous delivery, releases and production environments',
      icon: Icons.rocket_launch_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
            items: [
              _deployment(
                'Successful Deployments',
                '48',
                'This month',
                Icons.check_circle_outline,
              ),
              _deployment(
                'Production Releases',
                '18',
                'This month',
                Icons.rocket_launch_outlined,
              ),
              _deployment(
                'Pipeline Runs',
                '284',
                'Today',
                Icons.account_tree_outlined,
              ),
              _deployment(
                'Build Success Rate',
                '98.7%',
                'Excellent',
                Icons.build_circle_outlined,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _deployment(
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 9,
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

  Widget _backupAndRecovery(double width) {
    return _card(
      title: 'Backup & Disaster Recovery',
      subtitle: 'Data protection, backup schedules and recovery readiness',
      icon: Icons.backup_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
            items: [
              _recovery(
                'Backup Success',
                '100%',
                'All scheduled jobs',
                Icons.backup_outlined,
              ),
              _recovery(
                'Recovery Points',
                '186',
                'Available',
                Icons.restore_outlined,
              ),
              _recovery(
                'RPO',
                '15 min',
                'Target achieved',
                Icons.timer_outlined,
              ),
              _recovery(
                'RTO',
                '42 min',
                'Target achieved',
                Icons.history_outlined,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _recovery(String title, String value, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 9,
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

  Widget _regionalInfrastructure(double width) {
    return _card(
      title: 'Regional Infrastructure',
      subtitle: 'Cloud resources distributed across active regions',
      icon: Icons.public_outlined,
      child: Column(
        children: [
          _regionRow('Asia Pacific', 'Mumbai', '32 resources', 'Healthy', .92),
          _divider(),
          _regionRow(
            'Asia Pacific',
            'Singapore',
            '26 resources',
            'Healthy',
            .87,
          ),
          _divider(),
          _regionRow('Europe', 'Frankfurt', '18 resources', 'Healthy', .76),
          _divider(),
          _regionRow(
            'North America',
            'Virginia',
            '24 resources',
            'Healthy',
            .84,
          ),
          _divider(),
          _regionRow('Europe', 'London', '14 resources', 'Healthy', .68),
        ],
      ),
    );
  }

  Widget _regionRow(
    String region,
    String location,
    String resources,
    String status,
    double utilization,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF64748B),
                      size: 19,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        '$region • $location',
                        style: const TextStyle(
                          color: Color(0xFF334155),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      status,
                      style: const TextStyle(
                        color: Color(0xFF15803D),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: utilization,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      resources,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF64748B),
                size: 19,
              ),
              const SizedBox(width: 9),
              SizedBox(
                width: 190,
                child: Text(
                  '$region • $location',
                  style: const TextStyle(
                    color: Color(0xFF334155),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: utilization,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              SizedBox(
                width: 90,
                child: Text(
                  resources,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Color(0xFF64748B), fontSize: 9),
                ),
              ),
              const SizedBox(width: 14),
              SizedBox(
                width: 55,
                child: Text(
                  status,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _alertsAndIncidents(double width) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [_alerts(), const SizedBox(height: 16), _incidents()],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _alerts()),
            const SizedBox(width: 16),
            Expanded(child: _incidents()),
          ],
        );
      },
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
          _divider(),
          _alert(
            Icons.info_outline,
            'Platform update',
            'A new platform version is available.',
            'Info',
          ),
          _divider(),
          _alert(
            Icons.check_circle_outline,
            'Security scan',
            'No critical security issues detected.',
            'Done',
          ),
          _divider(),
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

  Widget _incidents() {
    return _card(
      title: 'Incident Management',
      subtitle: 'Production incidents and service events',
      icon: Icons.report_problem_outlined,
      child: Column(
        children: [
          _incident(
            'INC-2048',
            'API latency increase',
            'Resolved',
            '18 min ago',
          ),
          _divider(),
          _incident(
            'INC-2047',
            'Database connection alert',
            'Monitoring',
            '42 min ago',
          ),
          _divider(),
          _incident('INC-2046', 'CDN cache issue', 'Resolved', '2 hours ago'),
          _divider(),
          _incident(
            'INC-2045',
            'Authentication timeout',
            'Resolved',
            '5 hours ago',
          ),
        ],
      ),
    );
  }

  Widget _incident(String id, String title, String status, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.warning_amber_outlined,
              color: Color(0xFF64748B),
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$id • $title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  time,
                  style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 9),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Text(
            status,
            style: TextStyle(
              color: status == 'Monitoring'
                  ? const Color(0xFFB45309)
                  : const Color(0xFF15803D),
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF6B7280), fontSize: 9),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 9,
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
      subtitle: 'Deployments, databases, APIs, backups and automation',
      icon: Icons.settings_suggest_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 4
              : constraints.maxWidth >= 600
              ? 2
              : 1;

          return _grid(
            columns: columns,
            spacing: 12,
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
              _operation(
                Icons.schedule_outlined,
                'Automation Jobs',
                '142',
                'Scheduled',
              ),
              _operation(Icons.rule_outlined, 'Workflows', '86', 'Running'),
              _operation(
                Icons.integration_instructions_outlined,
                'Integrations',
                '54',
                'Connected',
              ),
              _operation(
                Icons.storage_outlined,
                'Object Storage',
                '12.8M',
                'Objects',
              ),
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 9,
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
      subtitle: 'Latest events across your enterprise cloud platform',
      icon: Icons.history_outlined,
      child: Column(
        children: [
          _activity(
            Icons.login_outlined,
            'Administrator signed in',
            'Successful authentication from authorized device',
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
            Icons.rocket_launch_outlined,
            'Production deployment completed',
            'Application release v4.8.2 deployed successfully',
            '21 min ago',
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF6B7280), fontSize: 9),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 9),
          ),
        ],
      ),
    );
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
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
                        fontSize: 16,
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
                        fontSize: 10,
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

  Widget _divider() {
    return const Divider(height: 1, color: Color(0xFFE5E7EB));
  }

  Widget _grid({
    required List<Widget> items,
    required int columns,
    required double spacing,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
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
