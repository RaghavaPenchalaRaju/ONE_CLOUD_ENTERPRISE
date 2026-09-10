import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/app_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;
  bool rememberMe = false;

  static const String validEmail = 'raghavapenchalraju@thestackly.com';

  static const String validPassword = 'Sunny@9898';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    final String email = emailController.text.trim();
    final String password = passwordController.text;

    if (email == validEmail && password == validPassword) {
      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacementNamed(context, AppRoutes.twoStep);
    } else {
      setState(() {
        isLoading = false;
      });

      _showMessage('Invalid email address or password.', isError: true);
    }
  }

  void _googleLogin() {
    _showMessage('Google authentication is ready to be connected.');
  }

  void _mobileLogin() {
    _showMessage('Mobile authentication is ready to be connected.');
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.info_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError
            ? const Color(0xFFB42318)
            : const Color(0xFF334155),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 470),
              child: Column(
                children: [
                  _buildLogo(),
                  const SizedBox(height: 28),
                  _buildLoginCard(),
                  const SizedBox(height: 22),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Column(children: [AppLogo(iconSize: 34, textSize: 17)]);
  }

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Sign in to access your enterprise workspace.',
              style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
            ),

            const SizedBox(height: 30),

            const Text(
              'Email address',
              style: TextStyle(
                color: Color(0xFF374151),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration(
                hint: 'Enter your email address',
                icon: Icons.email_outlined,
              ),
              validator: (value) {
                final String email = value?.trim() ?? '';

                if (email.isEmpty) {
                  return 'Please enter your email address';
                }

                if (!email.contains('@') || !email.contains('.')) {
                  return 'Enter a valid email address';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Password',
              style: TextStyle(
                color: Color(0xFF374151),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _login(),
              decoration: _inputDecoration(
                hint: 'Enter your password',
                icon: Icons.lock_outline,
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
                    color: const Color(0xFF6B7280),
                    size: 20,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }

                if (value.length < 6) {
                  return 'Password must contain at least 6 characters';
                }

                return null;
              },
            ),

            const SizedBox(height: 13),

            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 7),
                const Text(
                  'Remember me',
                  style: TextStyle(color: Color(0xFF4B5563), fontSize: 13),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF2563EB),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF93B4E8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 21,
                        height: 21,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _socialButton(
                    icon: Icons.g_mobiledata,
                    title: 'Google',
                    onTap: _googleLogin,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _socialButton(
                    icon: Icons.phone_android_outlined,
                    title: 'Mobile',
                    onTap: _mobileLogin,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Color(0xFF475569),
                    size: 18,
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Your account is protected with '
                      'two-step authentication.',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
      prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDC2626)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 46,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF374151),
          side: const BorderSide(color: Color(0xFFDDE2E8)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 21),
            const SizedBox(width: 7),
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Text(
      '© 2026 ONE CLOUD ENTERPRISE PLATFORM',
      textAlign: TextAlign.center,
      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
    );
  }
}
