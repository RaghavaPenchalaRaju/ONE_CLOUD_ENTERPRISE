import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const EnterpriseCloudApp());
}

class EnterpriseCloudApp extends StatelessWidget {
  const EnterpriseCloudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ONE CLOUD ENTERPRISE PLATFORM',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
