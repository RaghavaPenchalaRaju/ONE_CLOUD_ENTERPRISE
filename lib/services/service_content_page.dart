import 'package:flutter/material.dart';

import '../routes/service_routes.dart';

class ServiceContentPage extends StatelessWidget {
  final String page;

  const ServiceContentPage({super.key, required this.page});

  ServiceGroup? get group {
    for (final service in ServiceRoutes.groups) {
      if (service.title == page) {
        return service;
      }

      for (final item in service.items) {
        if (item.title == page) {
          return service;
        }
      }
    }

    return null;
  }

  ServiceItem? get item {
    final service = group;

    if (service == null) {
      return null;
    }

    for (final child in service.items) {
      if (child.title == page) {
        return child;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final service = group;

    if (service == null) {
      return _notFound();
    }

    final selectedItem = item;

    if (selectedItem == null) {
      return _serviceOverview(context, service);
    }

    return _module(service, selectedItem);
  }

  Widget _serviceOverview(BuildContext context, ServiceGroup service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hero(service.title, 'Enterprise service domain', service.icon),
        const SizedBox(height: 20),
        _descriptionCard(
          'Service Overview',
          _serviceDescription(service.title),
          Icons.info_outline,
        ),
        const SizedBox(height: 20),
        _modules(service),
        const SizedBox(height: 20),
        _cloudCapabilities(service.title),
      ],
    );
  }

  Widget _module(ServiceGroup service, ServiceItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hero(item.title, '${service.title}  •  Module', item.icon),
        const SizedBox(height: 20),
        _statusCards(),
        const SizedBox(height: 20),
        _descriptionCard(
          'Module Overview',
          _moduleDescription(item.title),
          Icons.info_outline,
        ),
        const SizedBox(height: 20),
        _descriptionCard(
          'Core Capabilities',
          '',
          Icons.checklist_outlined,
          child: Column(
            children: _capabilities(item.title).map(_bullet).toList(),
          ),
        ),
        const SizedBox(height: 20),
        _cloudCapabilities(service.title),
      ],
    );
  }

  Widget _hero(String title, String subtitle, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF172B4D), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.13),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCards() {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _status('Status', 'Operational', Icons.check_circle_outline),
        _status('API', 'Ready', Icons.api_outlined),
        _status('Security', 'RBAC', Icons.security_outlined),
        _status('Audit', 'Enabled', Icons.fact_check_outlined),
      ],
    );
  }

  Widget _status(String title, String value, IconData icon) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 22),
          const SizedBox(width: 10),
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
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 13,
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

  Widget _modules(ServiceGroup service) {
    return _descriptionCard(
      'Available Modules',
      '',
      Icons.apps_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          int columns = 1;

          if (constraints.maxWidth >= 950) {
            columns = 3;
          } else if (constraints.maxWidth >= 600) {
            columns = 2;
          }

          const spacing = 13.0;

          final width =
              (constraints.maxWidth - ((columns - 1) * spacing)) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: service.items.map((child) {
              return SizedBox(
                width: width,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, child.route);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          child.icon,
                          color: const Color(0xFF2563EB),
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            child.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF172B4D),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _cloudCapabilities(String service) {
    return _descriptionCard(
      'Cloud Platform Capabilities',
      'Provider-neutral cloud capabilities that can support $service.',
      Icons.cloud_outlined,
      child: Wrap(
        spacing: 9,
        runSpacing: 9,
        children: _cloudItems(service)
            .map(
              (text) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF1D4ED8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _descriptionCard(
    String title,
    String description,
    IconData icon, {
    Widget? child,
  }) {
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
              Icon(icon, color: const Color(0xFF2563EB), size: 21),
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
          if (description.isNotEmpty) ...[
            const SizedBox(height: 13),
            Text(
              description,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
          if (child != null) ...[const SizedBox(height: 16), child],
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2563EB), size: 17),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notFound() {
    return _descriptionCard(
      'Page Not Found',
      'The selected service could not be found.',
      Icons.error_outline,
    );
  }

  String _serviceDescription(String title) {
    switch (title) {
      case 'Platform Administration':
        return 'Centralized administration of global platform settings, '
            'tenants, licenses, features, resources and platform health.';

      case 'HRMS':
        return 'Enterprise workforce management covering employees, '
            'attendance, leave, payroll, recruitment, performance and learning.';

      case 'CRM':
        return 'Customer relationship management covering leads, accounts, '
            'contacts, opportunities, campaigns, quotations and support.';

      case 'ERP':
        return 'Enterprise resource planning covering inventory, procurement, '
            'production, sales, dispatch, assets, maintenance and vendors.';

      case 'Finance & Accounting':
        return 'Financial operations covering ledgers, payables, receivables, '
            'tax, budgeting, costing, reconciliation and financial reporting.';

      case 'Workflow & Automation':
        return 'Business process automation using workflows, approvals, '
            'business rules, tasks, triggers and SLA management.';

      case 'Documentation':
        return 'Enterprise document lifecycle management covering storage, '
            'versioning, access control, search, retention and audit trails.';

      case 'Subscription':
        return 'Subscription lifecycle management covering plans, features, '
            'quotas, payments, licensing, renewals and billing integration.';

      case 'Revenue':
        return 'Revenue management covering tracking, forecasting, analytics, '
            'recognition, commissions, invoicing and financial integrations.';

      case 'Monitoring':
        return 'Centralized observability for infrastructure, applications, '
            'logs, metrics, alerts, incidents and uptime.';

      case 'Storage':
        return 'Enterprise data storage covering object, file and block storage, '
            'backups, lifecycle policies, analytics and access management.';

      default:
        return 'Enterprise service management capabilities.';
    }
  }

  String _moduleDescription(String title) {
    final t = title.toLowerCase();

    if (t.contains('employee')) {
      return 'Centralizes employee master data, employment information, '
          'organizational details and workforce records.';
    }

    if (t.contains('attendance')) {
      return 'Manages employee attendance, working hours, shifts and attendance records.';
    }

    if (t == 'leave') {
      return 'Manages leave requests, approvals, balances, policies and leave history.';
    }

    if (t.contains('payroll')) {
      return 'Supports salary structures, payroll calculations, deductions, earnings and payslips.';
    }

    if (t.contains('recruitment')) {
      return 'Manages job openings, candidates, interviews, selection stages and recruitment workflows.';
    }

    if (t.contains('performance')) {
      return 'Supports employee goals, reviews, ratings, feedback and performance tracking.';
    }

    if (t.contains('learning')) {
      return 'Manages training programs, courses, assignments and learning progress.';
    }

    if (t.contains('lead')) {
      return 'Captures, qualifies and manages prospective customers through the sales lifecycle.';
    }

    if (t.contains('opportunit')) {
      return 'Tracks sales opportunities, pipeline stages, values and expected outcomes.';
    }

    if (t.contains('account')) {
      return 'Maintains customer account information, relationships and business activity.';
    }

    if (t.contains('contact')) {
      return 'Centralizes customer contact information and communication relationships.';
    }

    if (t.contains('pipeline')) {
      return 'Provides visual sales pipeline tracking across configurable business stages.';
    }

    if (t.contains('quotation')) {
      return 'Supports quotation creation, pricing, approval and customer quotation tracking.';
    }

    if (t.contains('campaign')) {
      return 'Manages marketing campaigns, target audiences, activities and campaign performance.';
    }

    if (t.contains('support')) {
      return 'Manages customer support cases, assignments, priorities, SLAs and resolutions.';
    }

    if (t.contains('inventory')) {
      return 'Provides stock visibility, warehouse information, inventory movements and availability.';
    }

    if (t.contains('procurement')) {
      return 'Manages purchase requests, purchase orders, suppliers and procurement approvals.';
    }

    if (t.contains('production')) {
      return 'Supports production planning, work orders, manufacturing activities and tracking.';
    }

    if (t.contains('sales order')) {
      return 'Manages customer sales orders, fulfillment, status and transaction processing.';
    }

    if (t.contains('dispatch')) {
      return 'Manages dispatch planning, shipments, deliveries and logistics information.';
    }

    if (t.contains('vendor')) {
      return 'Centralizes supplier profiles, vendor information and vendor performance.';
    }

    if (t.contains('ledger')) {
      return 'Manages journal entries, financial accounts, balances and ledger transactions.';
    }

    if (t.contains('payable')) {
      return 'Manages supplier invoices, payable transactions and payment obligations.';
    }

    if (t.contains('receivable')) {
      return 'Tracks customer invoices, outstanding balances, collections and receipts.';
    }

    if (t.contains('tax')) {
      return 'Supports tax configuration, calculations, tax records and reporting.';
    }

    if (t.contains('budget')) {
      return 'Provides budget planning, allocation, monitoring and variance analysis.';
    }

    if (t.contains('costing')) {
      return 'Supports cost allocation, cost centers and enterprise costing analysis.';
    }

    if (t.contains('financial report')) {
      return 'Provides financial statements, management reports and financial analytics.';
    }

    if (t.contains('reconciliation')) {
      return 'Helps reconcile transactions, account balances and external financial records.';
    }

    if (t.contains('currency')) {
      return 'Supports multiple currencies, exchange rates and international transactions.';
    }

    if (t.contains('workflow')) {
      return 'Provides configurable workflow design, stages, actions and process routing.';
    }

    if (t.contains('approval')) {
      return 'Manages approval chains, approvers, decisions, comments and approval status.';
    }

    if (t.contains('business rule')) {
      return 'Provides configurable business logic, validations and conditional processing.';
    }

    if (t.contains('automation')) {
      return 'Automates repetitive business processes using triggers, conditions and actions.';
    }

    if (t.contains('task')) {
      return 'Provides task creation, assignment, priority, tracking and completion management.';
    }

    if (t.contains('trigger')) {
      return 'Executes automated actions based on events, schedules or business conditions.';
    }

    if (t.contains('sla')) {
      return 'Tracks service-level agreements, deadlines, escalations and response commitments.';
    }

    if (t.contains('document')) {
      return 'Provides centralized enterprise document management and controlled access.';
    }

    if (t.contains('version')) {
      return 'Maintains document versions, revisions and change history.';
    }

    if (t.contains('upload')) {
      return 'Provides secure file upload and download with access and audit controls.';
    }

    if (t.contains('ocr')) {
      return 'Supports document text extraction and searchable content using OCR integrations.';
    }

    if (t.contains('subscription')) {
      return 'Manages tenant subscription status, lifecycle, plans and entitlements.';
    }

    if (t.contains('plan')) {
      return 'Defines subscription plans, features, pricing and service entitlements.';
    }

    if (t.contains('quota')) {
      return 'Tracks tenant usage against configured service limits and resource quotas.';
    }

    if (t.contains('payment')) {
      return 'Tracks payment transactions, payment status and payment history.';
    }

    if (t.contains('renewal')) {
      return 'Manages subscription renewals, dates, status and renewal workflows.';
    }

    if (t.contains('trial')) {
      return 'Controls trial subscriptions, duration, limits and trial conversion.';
    }

    if (t.contains('revenue')) {
      return 'Tracks revenue, revenue-related transactions and business performance.';
    }

    if (t.contains('forecast')) {
      return 'Provides revenue forecasting based on historical and operational data.';
    }

    if (t.contains('commission')) {
      return 'Manages commission rules, eligible transactions and commission calculations.';
    }

    if (t.contains('invoice')) {
      return 'Supports invoice creation, billing information, status and transaction records.';
    }

    if (t.contains('health')) {
      return 'Provides operational health visibility for services and infrastructure.';
    }

    if (t.contains('infrastructure')) {
      return 'Monitors infrastructure resources, availability and utilization.';
    }

    if (t.contains('application')) {
      return 'Tracks application performance, errors, availability and application signals.';
    }

    if (t.contains('log')) {
      return 'Centralizes logs for searching, troubleshooting and operational analysis.';
    }

    if (t.contains('alert')) {
      return 'Manages alert rules, severity, notification routing and operational response.';
    }

    if (t.contains('incident')) {
      return 'Supports incident creation, assignment, prioritization, resolution and history.';
    }

    if (t.contains('uptime')) {
      return 'Tracks service availability using configurable health checks and monitoring endpoints.';
    }

    if (t.contains('object storage')) {
      return 'Provides scalable object storage for documents, media, backups and application data.';
    }

    if (t.contains('file storage')) {
      return 'Provides shared file storage for enterprise workloads requiring file access.';
    }

    if (t.contains('block storage')) {
      return 'Provides persistent block volumes for compute and application workloads.';
    }

    if (t.contains('bucket')) {
      return 'Provides logical storage containers for organizing objects and permissions.';
    }

    if (t.contains('lifecycle')) {
      return 'Automates storage transitions, archival, retention and deletion policies.';
    }

    if (t.contains('backup')) {
      return 'Provides backup creation, retention, recovery and restore capabilities.';
    }

    if (t.contains('storage analytics')) {
      return 'Provides storage utilization, capacity, growth and usage analytics.';
    }

    return 'Provides centralized enterprise management capabilities for $title.';
  }

  List<String> _capabilities(String title) {
    final t = title.toLowerCase();

    if (t.contains('monitor') || t.contains('health') || t.contains('uptime')) {
      return [
        'Operational health visibility',
        'Metrics and monitoring signals',
        'Alerts and incident workflows',
        'Availability and performance analysis',
      ];
    }

    if (t.contains('storage') || t.contains('backup') || t.contains('bucket')) {
      return [
        'Secure data storage',
        'Role-based access control',
        'Backup and recovery',
        'Lifecycle management',
      ];
    }

    if (t.contains('workflow') ||
        t.contains('approval') ||
        t.contains('automation') ||
        t.contains('task')) {
      return [
        'Configurable business processes',
        'Approval and task routing',
        'Rules and automated actions',
        'Process tracking and auditability',
      ];
    }

    if (t.contains('finance') ||
        t.contains('ledger') ||
        t.contains('payment') ||
        t.contains('revenue')) {
      return [
        'Transaction management',
        'Financial controls',
        'Reporting and analytics',
        'Enterprise integrations',
      ];
    }

    return [
      'Centralized enterprise data management',
      'Role-based access control',
      'API integration readiness',
      'Audit and operational visibility',
    ];
  }

  List<String> _cloudItems(String service) {
    final s = service.toLowerCase();

    if (s.contains('monitoring')) {
      return [
        'Metrics',
        'Logs',
        'Alerts',
        'Health Checks',
        'Dashboards',
        'Incident Tracking',
      ];
    }

    if (s.contains('storage')) {
      return [
        'Object Storage',
        'File Storage',
        'Block Storage',
        'Backup',
        'Encryption',
        'Lifecycle Management',
      ];
    }

    if (s.contains('finance') ||
        s.contains('revenue') ||
        s.contains('subscription')) {
      return [
        'Managed Database',
        'Secure APIs',
        'Audit Logs',
        'Encryption',
        'Analytics',
        'Integration',
      ];
    }

    return [
      'Managed Database',
      'Identity & RBAC',
      'API Gateway',
      'Object Storage',
      'Monitoring',
      'Audit Logs',
    ];
  }
}
