import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/app_logo.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushNamed(context, AppRoutes.resetPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                children: [
                  const AppLogo(iconSize: 40, textSize: 20),
                  const SizedBox(height: 30),
                  _card(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.lock_reset_outlined,
              color: Color(0xFF2563EB),
              size: 42,
            ),
            const SizedBox(height: 15),
            const Text(
              'Forgot Password',
              style: TextStyle(
                color: Color(0xFF172B4D),
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Enter your registered email address to continue.',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
            ),
            const SizedBox(height: 24),
            const Text(
              'Email Address',
              style: TextStyle(
                color: Color(0xFF374151),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 7),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                filled: true,
                fillColor: Color(0xFFF8FAFC),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required.';
                }

                if (!value.contains('@')) {
                  return 'Enter a valid email.';
                }

                return null;
              },
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
