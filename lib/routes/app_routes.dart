import 'package:flutter/material.dart';

import '../authentication/forgot_password_page.dart';
import '../authentication/login_page.dart';
import '../authentication/reset_password_page.dart';
import '../authentication/two_step_page.dart';
import '../dashboard/dashboard_page.dart';
import '../dashboard/profile_page.dart';
import '../dashboard/settings_page.dart';
import '../services/service_content_page.dart';
import 'service_routes.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String twoStep = '/two-step';

  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes {
    final Map<String, WidgetBuilder> result = {
      login: (context) => const LoginPage(),
      forgotPassword: (context) => const ForgotPasswordPage(),
      resetPassword: (context) => const ResetPasswordPage(),
      twoStep: (context) => const TwoStepPage(),

      dashboard: (context) => const DashboardPage(),
      profile: (context) => const ProfilePage(),
      settings: (context) => const SettingsPage(),
    };

    for (final group in ServiceRoutes.groups) {
      result[group.route] = (context) {
        return DashboardPage(initialPage: group.title);
      };

      for (final item in group.items) {
        result[item.route] = (context) {
          return DashboardPage(initialPage: item.title);
        };
      }
    }

    return result;
  }
}
