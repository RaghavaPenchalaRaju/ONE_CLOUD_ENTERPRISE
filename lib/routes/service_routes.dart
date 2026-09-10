import 'package:flutter/material.dart';

class ServiceItem {
  final String title;
  final String route;
  final IconData icon;

  const ServiceItem({
    required this.title,
    required this.route,
    required this.icon,
  });
}

class ServiceGroup {
  final String title;
  final String route;
  final IconData icon;
  final List<ServiceItem> items;

  const ServiceGroup({
    required this.title,
    required this.route,
    required this.icon,
    required this.items,
  });
}

class ServiceRoutes {
  static const String dashboard = '/dashboard';

  static const String platformAdministration = '/platform-administration';

  static const String hrms = '/hrms';

  static const String crm = '/crm';

  static const String erp = '/erp';

  static const String financeAccounting = '/finance-accounting';

  static const String workflowAutomation = '/workflow-automation';

  static const String documentation = '/documentation';

  static const String subscription = '/subscription';

  static const String revenue = '/revenue';

  static const String monitoring = '/monitoring';

  static const String storage = '/storage';

  static const List<ServiceGroup> groups = [
    ServiceGroup(
      title: 'Platform Administration',
      route: platformAdministration,
      icon: Icons.admin_panel_settings_outlined,
      items: [
        ServiceItem(
          title: 'Global Settings',
          route: '/platform-administration/global-settings',
          icon: Icons.settings_outlined,
        ),
        ServiceItem(
          title: 'Platform Config',
          route: '/platform-administration/platform-config',
          icon: Icons.tune_outlined,
        ),
        ServiceItem(
          title: 'License Management',
          route: '/platform-administration/license-management',
          icon: Icons.card_membership_outlined,
        ),
        ServiceItem(
          title: 'Feature Management',
          route: '/platform-administration/feature-management',
          icon: Icons.extension_outlined,
        ),
        ServiceItem(
          title: 'Resource Management',
          route: '/platform-administration/resource-management',
          icon: Icons.inventory_2_outlined,
        ),
        ServiceItem(
          title: 'System Health',
          route: '/platform-administration/system-health',
          icon: Icons.monitor_heart_outlined,
        ),
        ServiceItem(
          title: 'Tenant Templates',
          route: '/platform-administration/tenant-templates',
          icon: Icons.business_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'HRMS',
      route: hrms,
      icon: Icons.people_alt_outlined,
      items: [
        ServiceItem(
          title: 'Employee Management',
          route: '/hrms/employee-management',
          icon: Icons.person_outline,
        ),
        ServiceItem(
          title: 'Attendance',
          route: '/hrms/attendance',
          icon: Icons.access_time_outlined,
        ),
        ServiceItem(
          title: 'Leave',
          route: '/hrms/leave',
          icon: Icons.event_available_outlined,
        ),
        ServiceItem(
          title: 'Payroll',
          route: '/hrms/payroll',
          icon: Icons.payments_outlined,
        ),
        ServiceItem(
          title: 'Recruitment',
          route: '/hrms/recruitment',
          icon: Icons.person_search_outlined,
        ),
        ServiceItem(
          title: 'Performance',
          route: '/hrms/performance',
          icon: Icons.trending_up_outlined,
        ),
        ServiceItem(
          title: 'Learning',
          route: '/hrms/learning',
          icon: Icons.school_outlined,
        ),
        ServiceItem(
          title: 'ESS / MSS',
          route: '/hrms/ess-mss',
          icon: Icons.account_circle_outlined,
        ),
        ServiceItem(
          title: 'Asset Management',
          route: '/hrms/asset-management',
          icon: Icons.devices_other_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'CRM',
      route: crm,
      icon: Icons.support_agent_outlined,
      items: [
        ServiceItem(
          title: 'Leads',
          route: '/crm/leads',
          icon: Icons.person_add_alt_outlined,
        ),
        ServiceItem(
          title: 'Opportunities',
          route: '/crm/opportunities',
          icon: Icons.lightbulb_outline,
        ),
        ServiceItem(
          title: 'Accounts',
          route: '/crm/accounts',
          icon: Icons.business_outlined,
        ),
        ServiceItem(
          title: 'Contacts',
          route: '/crm/contacts',
          icon: Icons.contacts_outlined,
        ),
        ServiceItem(
          title: 'Activities',
          route: '/crm/activities',
          icon: Icons.task_alt_outlined,
        ),
        ServiceItem(
          title: 'Pipeline',
          route: '/crm/pipeline',
          icon: Icons.account_tree_outlined,
        ),
        ServiceItem(
          title: 'Quotations',
          route: '/crm/quotations',
          icon: Icons.request_quote_outlined,
        ),
        ServiceItem(
          title: 'Campaigns',
          route: '/crm/campaigns',
          icon: Icons.campaign_outlined,
        ),
        ServiceItem(
          title: 'Customer Support',
          route: '/crm/customer-support',
          icon: Icons.headset_mic_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'ERP',
      route: erp,
      icon: Icons.business_center_outlined,
      items: [
        ServiceItem(
          title: 'Inventory',
          route: '/erp/inventory',
          icon: Icons.inventory_2_outlined,
        ),
        ServiceItem(
          title: 'Procurement',
          route: '/erp/procurement',
          icon: Icons.shopping_cart_outlined,
        ),
        ServiceItem(
          title: 'Production',
          route: '/erp/production',
          icon: Icons.precision_manufacturing_outlined,
        ),
        ServiceItem(
          title: 'Sales Orders',
          route: '/erp/sales-orders',
          icon: Icons.receipt_long_outlined,
        ),
        ServiceItem(
          title: 'Dispatch',
          route: '/erp/dispatch',
          icon: Icons.local_shipping_outlined,
        ),
        ServiceItem(
          title: 'Asset Management',
          route: '/erp/asset-management',
          icon: Icons.business_outlined,
        ),
        ServiceItem(
          title: 'Maintenance',
          route: '/erp/maintenance',
          icon: Icons.build_outlined,
        ),
        ServiceItem(
          title: 'Vendors',
          route: '/erp/vendors',
          icon: Icons.storefront_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'Finance & Accounting',
      route: financeAccounting,
      icon: Icons.account_balance_outlined,
      items: [
        ServiceItem(
          title: 'General Ledger',
          route: '/finance-accounting/general-ledger',
          icon: Icons.menu_book_outlined,
        ),
        ServiceItem(
          title: 'Accounts Payable',
          route: '/finance-accounting/accounts-payable',
          icon: Icons.money_off_outlined,
        ),
        ServiceItem(
          title: 'Accounts Receivable',
          route: '/finance-accounting/accounts-receivable',
          icon: Icons.account_balance_wallet_outlined,
        ),
        ServiceItem(
          title: 'Tax Management',
          route: '/finance-accounting/tax-management',
          icon: Icons.percent_outlined,
        ),
        ServiceItem(
          title: 'Budgeting',
          route: '/finance-accounting/budgeting',
          icon: Icons.pie_chart_outline,
        ),
        ServiceItem(
          title: 'Costing',
          route: '/finance-accounting/costing',
          icon: Icons.calculate_outlined,
        ),
        ServiceItem(
          title: 'Financial Reports',
          route: '/finance-accounting/financial-reports',
          icon: Icons.bar_chart_outlined,
        ),
        ServiceItem(
          title: 'Reconciliation',
          route: '/finance-accounting/reconciliation',
          icon: Icons.compare_arrows_outlined,
        ),
        ServiceItem(
          title: 'Multi-Currency',
          route: '/finance-accounting/multi-currency',
          icon: Icons.currency_exchange_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'Workflow & Automation',
      route: workflowAutomation,
      icon: Icons.account_tree_outlined,
      items: [
        ServiceItem(
          title: 'Workflow Builder',
          route: '/workflow-automation/workflow-builder',
          icon: Icons.build_circle_outlined,
        ),
        ServiceItem(
          title: 'Approvals',
          route: '/workflow-automation/approvals',
          icon: Icons.check_circle_outline,
        ),
        ServiceItem(
          title: 'Business Rules',
          route: '/workflow-automation/business-rules',
          icon: Icons.rule_outlined,
        ),
        ServiceItem(
          title: 'Process Automation',
          route: '/workflow-automation/process-automation',
          icon: Icons.auto_mode_outlined,
        ),
        ServiceItem(
          title: 'Task Management',
          route: '/workflow-automation/task-management',
          icon: Icons.task_alt_outlined,
        ),
        ServiceItem(
          title: 'Triggers',
          route: '/workflow-automation/triggers',
          icon: Icons.flash_on_outlined,
        ),
        ServiceItem(
          title: 'SLAs & Escalators',
          route: '/workflow-automation/slas-escalators',
          icon: Icons.timer_outlined,
        ),
        ServiceItem(
          title: 'Process Monitoring',
          route: '/workflow-automation/process-monitoring',
          icon: Icons.monitor_outlined,
        ),
        ServiceItem(
          title: 'Workflow Templates',
          route: '/workflow-automation/workflow-templates',
          icon: Icons.view_quilt_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'Documentation',
      route: documentation,
      icon: Icons.folder_copy_outlined,
      items: [
        ServiceItem(
          title: 'Document Repository',
          route: '/documentation/document-repository',
          icon: Icons.folder_outlined,
        ),
        ServiceItem(
          title: 'Versioning',
          route: '/documentation/versioning',
          icon: Icons.history_outlined,
        ),
        ServiceItem(
          title: 'File Upload / Download',
          route: '/documentation/file-upload-download',
          icon: Icons.file_upload_outlined,
        ),
        ServiceItem(
          title: 'Access Control',
          route: '/documentation/access-control',
          icon: Icons.lock_outline,
        ),
        ServiceItem(
          title: 'Document Templates',
          route: '/documentation/document-templates',
          icon: Icons.description_outlined,
        ),
        ServiceItem(
          title: 'Tagging & Search',
          route: '/documentation/tagging-search',
          icon: Icons.search_outlined,
        ),
        ServiceItem(
          title: 'Retention Policies',
          route: '/documentation/retention-policies',
          icon: Icons.policy_outlined,
        ),
        ServiceItem(
          title: 'Audit Trails',
          route: '/documentation/audit-trails',
          icon: Icons.fact_check_outlined,
        ),
        ServiceItem(
          title: 'OCR Integration',
          route: '/documentation/ocr-integration',
          icon: Icons.document_scanner_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'Subscription',
      route: subscription,
      icon: Icons.subscriptions_outlined,
      items: [
        ServiceItem(
          title: 'Plans & Features',
          route: '/subscription/plans-features',
          icon: Icons.layers_outlined,
        ),
        ServiceItem(
          title: 'Tenant Subscriptions',
          route: '/subscription/tenant-subscriptions',
          icon: Icons.business_outlined,
        ),
        ServiceItem(
          title: 'Usage & Quotas',
          route: '/subscription/usage-quotas',
          icon: Icons.data_usage_outlined,
        ),
        ServiceItem(
          title: 'Payment Tracking',
          route: '/subscription/payment-tracking',
          icon: Icons.payment_outlined,
        ),
        ServiceItem(
          title: 'License Allocation',
          route: '/subscription/license-allocation',
          icon: Icons.assignment_turned_in_outlined,
        ),
        ServiceItem(
          title: 'License Keys',
          route: '/subscription/license-keys',
          icon: Icons.key_outlined,
        ),
        ServiceItem(
          title: 'Renewals',
          route: '/subscription/renewals',
          icon: Icons.autorenew_outlined,
        ),
        ServiceItem(
          title: 'Trial Management',
          route: '/subscription/trial-management',
          icon: Icons.hourglass_empty_outlined,
        ),
        ServiceItem(
          title: 'Billing Integration',
          route: '/subscription/billing-integration',
          icon: Icons.receipt_long_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'Revenue',
      route: revenue,
      icon: Icons.trending_up_outlined,
      items: [
        ServiceItem(
          title: 'Revenue Tracking',
          route: '/revenue/revenue-tracking',
          icon: Icons.track_changes_outlined,
        ),
        ServiceItem(
          title: 'Usage Analytics',
          route: '/revenue/usage-analytics',
          icon: Icons.analytics_outlined,
        ),
        ServiceItem(
          title: 'Forecasting',
          route: '/revenue/forecasting',
          icon: Icons.show_chart_outlined,
        ),
        ServiceItem(
          title: 'Revenue Reports',
          route: '/revenue/revenue-reports',
          icon: Icons.bar_chart_outlined,
        ),
        ServiceItem(
          title: 'Revenue Recognition',
          route: '/revenue/revenue-recognition',
          icon: Icons.verified_outlined,
        ),
        ServiceItem(
          title: 'Commission Management',
          route: '/revenue/commission-management',
          icon: Icons.groups_outlined,
        ),
        ServiceItem(
          title: 'Financial Analytics',
          route: '/revenue/financial-analytics',
          icon: Icons.query_stats_outlined,
        ),
        ServiceItem(
          title: 'Invoicing',
          route: '/revenue/invoicing',
          icon: Icons.receipt_long_outlined,
        ),
        ServiceItem(
          title: 'Integration',
          route: '/revenue/integration',
          icon: Icons.integration_instructions_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'Monitoring',
      route: monitoring,
      icon: Icons.monitor_heart_outlined,
      items: [
        ServiceItem(
          title: 'Service Health',
          route: '/monitoring/service-health',
          icon: Icons.health_and_safety_outlined,
        ),
        ServiceItem(
          title: 'Infrastructure Monitoring',
          route: '/monitoring/infrastructure-monitoring',
          icon: Icons.dns_outlined,
        ),
        ServiceItem(
          title: 'Application Monitoring',
          route: '/monitoring/application-monitoring',
          icon: Icons.apps_outlined,
        ),
        ServiceItem(
          title: 'Log Monitoring',
          route: '/monitoring/log-monitoring',
          icon: Icons.article_outlined,
        ),
        ServiceItem(
          title: 'Alert Management',
          route: '/monitoring/alert-management',
          icon: Icons.notifications_active_outlined,
        ),
        ServiceItem(
          title: 'Performance Metrics',
          route: '/monitoring/performance-metrics',
          icon: Icons.speed_outlined,
        ),
        ServiceItem(
          title: 'Incident Management',
          route: '/monitoring/incident-management',
          icon: Icons.warning_amber_outlined,
        ),
        ServiceItem(
          title: 'Uptime Monitoring',
          route: '/monitoring/uptime-monitoring',
          icon: Icons.timer_outlined,
        ),
      ],
    ),

    ServiceGroup(
      title: 'Storage',
      route: storage,
      icon: Icons.storage_outlined,
      items: [
        ServiceItem(
          title: 'Object Storage',
          route: '/storage/object-storage',
          icon: Icons.folder_open_outlined,
        ),
        ServiceItem(
          title: 'File Storage',
          route: '/storage/file-storage',
          icon: Icons.folder_outlined,
        ),
        ServiceItem(
          title: 'Block Storage',
          route: '/storage/block-storage',
          icon: Icons.storage_outlined,
        ),
        ServiceItem(
          title: 'Storage Buckets',
          route: '/storage/storage-buckets',
          icon: Icons.inventory_2_outlined,
        ),
        ServiceItem(
          title: 'Lifecycle Policies',
          route: '/storage/lifecycle-policies',
          icon: Icons.update_outlined,
        ),
        ServiceItem(
          title: 'Backup & Restore',
          route: '/storage/backup-restore',
          icon: Icons.backup_outlined,
        ),
        ServiceItem(
          title: 'Storage Analytics',
          route: '/storage/storage-analytics',
          icon: Icons.analytics_outlined,
        ),
        ServiceItem(
          title: 'Access Management',
          route: '/storage/access-management',
          icon: Icons.lock_outline,
        ),
      ],
    ),
  ];
}
