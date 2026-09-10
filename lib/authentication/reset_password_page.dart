import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/app_logo.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();

  final confirmController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void _reset() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 45,
          ),
          title: const Text('Password Reset Successful'),
          content: const Text('Your password has been updated successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
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
              Icons.password_outlined,
              color: Color(0xFF2563EB),
              size: 42,
            ),
            const SizedBox(height: 15),
            const Text(
              'Reset Password',
              style: TextStyle(
                color: Color(0xFF172B4D),
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Create a new secure password for your account.',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
            ),
            const SizedBox(height: 25),
            _label('New Password'),
            const SizedBox(height: 7),
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: _decoration('Enter new password', Icons.lock_outline)
                  .copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required.';
                }

                if (value.length < 8) {
                  return 'Password must contain at least 8 characters.';
                }

                return null;
              },
            ),
            const SizedBox(height: 18),
            _label('Confirm Password'),
            const SizedBox(height: 7),
            TextFormField(
              controller: confirmController,
              obscureText: obscureConfirm,
              decoration:
                  _decoration(
                    'Confirm new password',
                    Icons.lock_outline,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirm = !obscureConfirm;
                        });
                      },
                      icon: Icon(
                        obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password.';
                }

                if (value != passwordController.text) {
                  return 'Passwords do not match.';
                }

                return null;
              },
            ),
            const SizedBox(height: 23),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF374151),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration _decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: const OutlineInputBorder(),
    );
  }
}
