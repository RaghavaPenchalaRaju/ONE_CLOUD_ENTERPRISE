import 'package:flutter/material.dart';

class ServiceContentPage extends StatelessWidget {
  final String page;

  const ServiceContentPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final data = _serviceData[page] ?? _defaultData(page);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _hero(context, data),
            const SizedBox(height: 20),
            _metrics(context, data),
            const SizedBox(height: 20),
            _mainSection(context, data, constraints.maxWidth),
            const SizedBox(height: 20),
            _activitySection(context, data, constraints.maxWidth),
            const SizedBox(height: 20),
            _resourceSection(context, data, constraints.maxWidth),
            const SizedBox(height: 20),
            _tableSection(context, data),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _hero(BuildContext context, Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF172B4D), Color(0xFF263F67)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heroInfo(data),
                const SizedBox(height: 20),
                _statusBadge(data),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _heroInfo(data)),
              _statusBadge(data),
            ],
          );
        },
      ),
    );
  }

  Widget _heroInfo(Map<String, dynamic> data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF2E466A),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(data['icon'], color: const Color(0xFFE2E8F0), size: 27),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                data['description'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFFCBD5E1),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFF1E334F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF3B516E)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF86EFAC), size: 17),
          const SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['status'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                data['availability'],
                style: const TextStyle(color: Color(0xFFAFC0D3), fontSize: 9),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metrics(BuildContext context, Map<String, dynamic> data) {
    final metrics = data['metrics'] as List<dynamic>;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1200
            ? 4
            : constraints.maxWidth >= 700
            ? 2
            : 1;

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: metrics.map((metric) {
            final width =
                (constraints.maxWidth - (14 * (columns - 1))) / columns;

            return SizedBox(width: width, child: _metricCard(metric));
          }).toList(),
        );
      },
    );
  }

  Widget _metricCard(Map<String, dynamic> metric) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              metric['icon'],
              color: const Color(0xFF64748B),
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  metric['value'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  metric['change'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

  Widget _mainSection(
    BuildContext context,
    Map<String, dynamic> data,
    double width,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 850) {
          return Column(
            children: [
              _overviewCard(data),
              const SizedBox(height: 16),
              _healthCard(data),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _overviewCard(data)),
            const SizedBox(width: 16),
            Expanded(flex: 2, child: _healthCard(data)),
          ],
        );
      },
    );
  }

  Widget _overviewCard(Map<String, dynamic> data) {
    return _card(
      title: 'Service Overview',
      subtitle: 'Current operational and platform information',
      icon: Icons.dashboard_customize_outlined,
      child: Column(
        children: [
          _infoRow('Environment', data['environment'], Icons.layers_outlined),
          _divider(),
          _infoRow('Owner', data['owner'], Icons.person_outline),
          _divider(),
          _infoRow('Region', data['region'], Icons.public_outlined),
          _divider(),
          _infoRow('Version', data['version'], Icons.new_releases_outlined),
          _divider(),
          _infoRow(
            'Last Deployment',
            data['deployment'],
            Icons.rocket_launch_outlined,
          ),
        ],
      ),
    );
  }

  Widget _healthCard(Map<String, dynamic> data) {
    return _card(
      title: 'Service Health',
      subtitle: 'Live operational indicators',
      icon: Icons.monitor_heart_outlined,
      child: Column(
        children: [
          _healthIndicator('Availability', data['availability'], 0.999),
          const SizedBox(height: 17),
          _healthIndicator('Performance', '98.4%', 0.984),
          const SizedBox(height: 17),
          _healthIndicator('Reliability', '99.8%', 0.998),
          const SizedBox(height: 17),
          _healthIndicator('Capacity', '72%', 0.72),
        ],
      ),
    );
  }

  Widget _healthIndicator(String title, String value, double progress) {
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
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF172B4D),
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF64748B)),
          ),
        ),
      ],
    );
  }

  Widget _activitySection(
    BuildContext context,
    Map<String, dynamic> data,
    double width,
  ) {
    return _card(
      title: 'Service Activity',
      subtitle: 'Recent events and operational changes',
      icon: Icons.timeline_outlined,
      child: Column(
        children: [
          _activity(
            Icons.check_circle_outline,
            data['activity1'],
            data['activity1Detail'],
            'Just now',
          ),
          _divider(),
          _activity(
            Icons.rocket_launch_outlined,
            data['activity2'],
            data['activity2Detail'],
            '18 min ago',
          ),
          _divider(),
          _activity(
            Icons.security_outlined,
            data['activity3'],
            data['activity3Detail'],
            '42 min ago',
          ),
          _divider(),
          _activity(
            Icons.settings_outlined,
            data['activity4'],
            data['activity4Detail'],
            '2 hours ago',
          ),
          _divider(),
          _activity(
            Icons.backup_outlined,
            data['activity5'],
            data['activity5Detail'],
            '4 hours ago',
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
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: const Color(0xFF64748B), size: 18),
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

  Widget _resourceSection(
    BuildContext context,
    Map<String, dynamic> data,
    double width,
  ) {
    final resources = data['resources'] as List<dynamic>;

    return _card(
      title: 'Resources & Components',
      subtitle: 'Infrastructure components associated with this service',
      icon: Icons.dns_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1000
              ? 3
              : constraints.maxWidth >= 650
              ? 2
              : 1;

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: resources.map((resource) {
              final itemWidth =
                  (constraints.maxWidth - (12 * (columns - 1))) / columns;

              return SizedBox(width: itemWidth, child: _resourceCard(resource));
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _resourceCard(Map<String, dynamic> resource) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(resource['icon'], color: const Color(0xFF64748B), size: 22),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  resource['value'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  resource['status'],
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

  Widget _tableSection(BuildContext context, Map<String, dynamic> data) {
    final rows = data['table'] as List<dynamic>;

    return _card(
      title: data['tableTitle'],
      subtitle: data['tableSubtitle'],
      icon: Icons.table_chart_outlined,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 720),
          child: DataTable(
            headingRowHeight: 46,
            dataRowMinHeight: 54,
            dataRowMaxHeight: 68,
            columnSpacing: 30,
            horizontalMargin: 8,
            headingTextStyle: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
            dataTextStyle: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 10,
            ),
            columns: [
              DataColumn(label: Text(data['column1'])),
              DataColumn(label: Text(data['column2'])),
              DataColumn(label: Text(data['column3'])),
              DataColumn(label: Text(data['column4'])),
            ],
            rows: rows.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(row[0], maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  DataCell(
                    Text(row[1], maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  DataCell(
                    Text(row[2], maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        row[3],
                        style: const TextStyle(
                          color: Color(0xFF15803D),
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF334155),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
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

  Map<String, dynamic> _defaultData(String title) {
    return _buildData(
      title: title,
      icon: Icons.apps_outlined,
      description: 'Enterprise service management, operational visibility and cloud platform controls.',
      owner: 'Platform Operations',
      environment: 'Production',
      region: 'Asia Pacific',
      version: 'v4.8.2',
      deployment: 'Today, 08:42',
      tableTitle: 'Service Components',
      tableSubtitle: 'Active components and operational state',
      column1: 'Component',
      column2: 'Version',
      column3: 'Load',
      column4: 'Status',
    );
  }

  Map<String, dynamic> _buildData({
    required String title,
    required IconData icon,
    required String description,
    required String owner,
    required String environment,
    required String region,
    required String version,
    required String deployment,
    required String tableTitle,
    required String tableSubtitle,
    required String column1,
    required String column2,
    required String column3,
    required String column4,
  }) {
    return {
      'title': title,
      'icon': icon,
      'description': description,
      'status': 'Operational',
      'availability': '99.99% availability',
      'owner': owner,
      'environment': environment,
      'region': region,
      'version': version,
      'deployment': deployment,
      'activity1': '$title health check completed',
      'activity1Detail': 'All service components are operating normally',
      'activity2': '$title deployment completed',
      'activity2Detail':
          'Latest production configuration deployed successfully',
      'activity3': 'Security validation completed',
      'activity3Detail': 'No critical security issues detected',
      'activity4': 'Service configuration synchronized',
      'activity4Detail': 'Enterprise configuration is up to date',
      'activity5': 'Backup completed',
      'activity5Detail': 'Scheduled service backup completed successfully',
      'tableTitle': tableTitle,
      'tableSubtitle': tableSubtitle,
      'column1': column1,
      'column2': column2,
      'column3': column3,
      'column4': column4,
      'metrics': [
        {
          'title': 'Service Availability',
          'value': '99.99%',
          'change': '+0.02% this month',
          'icon': Icons.check_circle_outline,
        },
        {
          'title': 'Active Requests',
          'value': '24.8K',
          'change': '+8.4% today',
          'icon': Icons.sync_outlined,
        },
        {
          'title': 'Average Latency',
          'value': '124 ms',
          'change': '-8.2% today',
          'icon': Icons.speed_outlined,
        },
        {
          'title': 'Error Rate',
          'value': '0.08%',
          'change': '-0.03% today',
          'icon': Icons.error_outline,
        },
      ],
      'resources': [
        {
          'title': 'Application Instances',
          'value': '24',
          'status': 'All healthy',
          'icon': Icons.dns_outlined,
        },
        {
          'title': 'API Endpoints',
          'value': '86',
          'status': 'Operational',
          'icon': Icons.api_outlined,
        },
        {
          'title': 'Database Connections',
          'value': '142',
          'status': 'Healthy',
          'icon': Icons.storage_outlined,
        },
        {
          'title': 'Container Workloads',
          'value': '38',
          'status': 'Running',
          'icon': Icons.view_in_ar_outlined,
        },
        {
          'title': 'Background Jobs',
          'value': '126',
          'status': 'Scheduled',
          'icon': Icons.schedule_outlined,
        },
        {
          'title': 'Service Dependencies',
          'value': '18',
          'status': 'Available',
          'icon': Icons.account_tree_outlined,
        },
      ],
      'table': [
        ['Primary Service', version, '42%', 'Healthy'],
        ['API Gateway', 'v3.6.1', '38%', 'Healthy'],
        ['Worker Cluster', 'v2.9.4', '61%', 'Healthy'],
        ['Database Layer', 'v12.4', '57%', 'Healthy'],
        ['Cache Layer', 'v7.2', '44%', 'Healthy'],
      ],
    };
  }

  static final Map<String, Map<String, dynamic>> _serviceData = {
    'Platform Administration': _staticData(
      'Platform Administration',
      Icons.admin_panel_settings_outlined,
      'Central administration for enterprise users, policies, configuration and platform governance.',
      'Platform Engineering',
      'Global',
    ),
    'HRMS': _staticData(
      'HRMS',
      Icons.badge_outlined,
      'Enterprise human resource management covering employee operations, workforce data and organizational administration.',
      'Human Resources',
      'Asia Pacific',
    ),
    'CRM': _staticData(
      'CRM',
      Icons.people_alt_outlined,
      'Customer relationship management covering accounts, contacts, opportunities, pipelines and customer engagement.',
      'Sales Operations',
      'Global',
    ),
    'ERP': _staticData(
      'ERP',
      Icons.business_center_outlined,
      'Enterprise resource planning platform for finance, procurement, operations, inventory and organizational workflows.',
      'Enterprise Operations',
      'Global',
    ),
    'Finance & Accounting': _staticData(
      'Finance & Accounting',
      Icons.account_balance_outlined,
      'Financial operations platform for accounting, transactions, reconciliation, reporting and financial controls.',
      'Finance Operations',
      'Asia Pacific',
    ),
    'Workflow & Automation': _staticData(
      'Workflow & Automation',
      Icons.account_tree_outlined,
      'Enterprise workflow orchestration for approvals, business processes, scheduled jobs and automated operations.',
      'Automation Engineering',
      'Global',
    ),
    'Documentation': _staticData(
      'Documentation',
      Icons.menu_book_outlined,
      'Central enterprise knowledge platform for documentation, policies, technical references and operational guides.',
      'Knowledge Management',
      'Global',
    ),
    'Subscription': _staticData(
      'Subscription',
      Icons.subscriptions_outlined,
      'Subscription lifecycle management for plans, accounts, renewals, billing cycles and customer entitlements.',
      'Revenue Operations',
      'Global',
    ),
    'Revenue': _staticData(
      'Revenue',
      Icons.trending_up_outlined,
      'Revenue intelligence platform covering financial performance, recurring revenue and commercial metrics.',
      'Revenue Operations',
      'Global',
    ),
    'Monitoring': _staticData(
      'Monitoring',
      Icons.monitor_heart_outlined,
      'Unified observability platform for application health, infrastructure metrics, logs, alerts and incidents.',
      'Site Reliability Engineering',
      'Global',
    ),
    'Storage': _staticData(
      'Storage',
      Icons.storage_outlined,
      'Enterprise cloud storage platform for application data, objects, backups and long-term retention.',
      'Cloud Infrastructure',
      'Asia Pacific',
    ),
    'Identity & Access': _staticData(
      'Identity & Access',
      Icons.manage_accounts_outlined,
      'Centralized identity, authentication, authorization, role management and enterprise access governance.',
      'Security Engineering',
      'Global',
    ),
  };

  static Map<String, dynamic> _staticData(
    String title,
    IconData icon,
    String description,
    String owner,
    String region,
  ) {
    final page = ServiceContentPage(page: title);

    return page._buildData(
      title: title,
      icon: icon,
      description: description,
      owner: owner,
      environment: 'Production',
      region: region,
      version: 'v4.8.2',
      deployment: 'Today, 08:42',
      tableTitle: '$title Components',
      tableSubtitle: 'Active resources and service components',
      column1: 'Component',
      column2: 'Version',
      column3: 'Utilization',
      column4: 'Status',
    );
  }
}
