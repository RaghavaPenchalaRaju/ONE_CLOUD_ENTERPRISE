import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  static const String validEmail = 'raghavapenchalraju@thestackly.com';

  static const String validPassword = 'Sunny@9898';

  bool obscurePassword = true;
  bool rememberMe = false;
  bool isLoading = false;

  late final AnimationController pageController;
  late final AnimationController cloudController;
  late final AnimationController dashboardController;
  late final AnimationController pulseController;
  late final AnimationController featureController;

  late final Animation<double> leftFade;
  late final Animation<double> rightFade;
  late final Animation<Offset> leftSlide;
  late final Animation<Offset> rightSlide;

  @override
  void initState() {
    super.initState();

    pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    cloudController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    dashboardController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    featureController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    leftFade = CurvedAnimation(
      parent: pageController,
      curve: const Interval(0, .7, curve: Curves.easeOut),
    );

    rightFade = CurvedAnimation(
      parent: pageController,
      curve: const Interval(.15, 1, curve: Curves.easeOut),
    );

    leftSlide = Tween<Offset>(begin: const Offset(-0.07, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: pageController,
            curve: const Interval(0, .8, curve: Curves.easeOutCubic),
          ),
        );

    rightSlide = Tween<Offset>(begin: const Offset(0.07, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: pageController,
            curve: const Interval(.15, 1, curve: Curves.easeOutCubic),
          ),
        );

    pageController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        featureController.forward();
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    pageController.dispose();
    cloudController.dispose();
    dashboardController.dispose();
    pulseController.dispose();
    featureController.dispose();
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

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) {
      return;
    }

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

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError
                  ? Icons.error_outline_rounded
                  : Icons.info_outline_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError
            ? const Color(0xFFB42318)
            : const Color(0xFF172033),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  void _googleLogin() {
    _showMessage('Google authentication is ready to be connected.');
  }

  void _mobileLogin() {
    _showMessage('Mobile authentication is ready to be connected.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 760) {
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
        Expanded(
          flex: 54,
          child: FadeTransition(
            opacity: leftFade,
            child: SlideTransition(
              position: leftSlide,
              child: _buildLeftPanel(),
            ),
          ),
        ),
        Expanded(
          flex: 46,
          child: FadeTransition(
            opacity: rightFade,
            child: SlideTransition(
              position: rightSlide,
              child: _buildRightPanel(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEAF4FF), Color(0xFFDCEBFB), Color(0xFFCBE2F8)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          _movingCloud(top: 65, left: 65, size: 90, speed: 1),
          _movingCloud(top: 155, right: 35, size: 70, speed: 1.4),
          _movingCloud(bottom: 205, left: 15, size: 105, speed: .8),
          _movingCloud(bottom: 45, right: 75, size: 120, speed: 1.1),
          _backgroundGlow(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(38, 28, 30, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBrand(),
                  const SizedBox(height: 48),
                  _buildHero(),
                  const SizedBox(height: 30),
                  _buildFeatures(),
                  const SizedBox(height: 40),
                  _buildDashboard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundGlow() {
    return AnimatedBuilder(
      animation: cloudController,
      builder: (context, child) {
        final double value = cloudController.value * math.pi * 2;

        return Stack(
          children: [
            Positioned(
              top: 40 + math.sin(value) * 20,
              right: 60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.17),
                ),
              ),
            ),
            Positioned(
              bottom: 50 + math.cos(value) * 18,
              left: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBrand() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.85),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1677E8).withOpacity(.08),
                blurRadius: 25,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.cloud_rounded,
            color: Color(0xFF1677E8),
            size: 28,
          ),
        ),
        const SizedBox(width: 13),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ONE CLOUD',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'ENTERPRISE PLATFORM',
              style: TextStyle(
                color: Color(0xFF1677E8),
                fontSize: 8,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Smart ',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: 'Cloud.',
                style: TextStyle(
                  color: Color(0xFF1677E8),
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Stronger Business.\nBetter Growth.',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 35,
            fontWeight: FontWeight.w900,
            height: 1.03,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Bring customers, projects, operations and '
          'business intelligence together in one secure '
          'enterprise cloud platform.',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 13,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 17),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _badge(Icons.shield_outlined, 'Enterprise Security'),
            _badge(Icons.bolt_rounded, 'High Performance'),
            _badge(Icons.cloud_done_outlined, 'Cloud Native'),
          ],
        ),
      ],
    );
  }

  Widget _badge(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.65),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(.9)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF1677E8)),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return AnimatedBuilder(
      animation: featureController,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 500) {
              return Column(
                children: [
                  _feature(
                    0,
                    Icons.people_alt_outlined,
                    'Manage Contacts',
                    'Organize customer relationships.',
                  ),
                  const SizedBox(height: 15),
                  _feature(
                    1,
                    Icons.auto_awesome_outlined,
                    'Automate Tasks',
                    'Improve productivity.',
                  ),
                  const SizedBox(height: 15),
                  _feature(
                    2,
                    Icons.trending_up_rounded,
                    'Track Projects',
                    'Plan and deliver efficiently.',
                  ),
                  const SizedBox(height: 15),
                  _feature(
                    3,
                    Icons.analytics_outlined,
                    'Powerful Reports',
                    'Turn data into decisions.',
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _feature(
                        0,
                        Icons.people_alt_outlined,
                        'Manage Contacts',
                        'Organize customer relationships.',
                      ),
                      const SizedBox(height: 18),
                      _feature(
                        2,
                        Icons.auto_awesome_outlined,
                        'Automate Tasks',
                        'Improve productivity.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    children: [
                      _feature(
                        1,
                        Icons.trending_up_rounded,
                        'Track Projects',
                        'Plan and deliver efficiently.',
                      ),
                      const SizedBox(height: 18),
                      _feature(
                        3,
                        Icons.analytics_outlined,
                        'Powerful Reports',
                        'Turn data into decisions.',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _feature(int index, IconData icon, String title, String description) {
    final double start = index * .12;

    final double progress = ((featureController.value - start) / .6).clamp(
      0.0,
      1.0,
    );

    final double value = Curves.easeOutCubic.transform(progress);

    return Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(0, 14 * (1 - value)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1677E8).withOpacity(.07),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Icon(icon, color: const Color(0xFF1677E8), size: 20),
            ),
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
                      color: Color(0xFF172033),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 9.5,
                      height: 1.35,
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

  Widget _buildDashboard() {
    return AnimatedBuilder(
      animation: dashboardController,
      builder: (context, child) {
        final double offset = math.sin(dashboardController.value * math.pi) * 5;

        return Transform.translate(offset: Offset(0, offset), child: child);
      },
      child: Container(
        width: double.infinity,
        height: 185,
        margin: const EdgeInsets.only(left: 28, right: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.96),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF315A80).withOpacity(.14),
              blurRadius: 35,
              offset: const Offset(0, 17),
            ),
          ],
        ),
        child: Row(
          children: [
            _dashboardSidebar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Business Overview',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF172033),
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        _dashboardPill(),
                        const SizedBox(width: 4),
                        _dashboardPill(),
                        const SizedBox(width: 4),
                        _dashboardPill(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _metric('Total Leads', '1,248', '+18.5%'),
                        const SizedBox(width: 6),
                        _metric('Active Deals', '842', '+11.2%'),
                        const SizedBox(width: 6),
                        _metric('Revenue', '\$328K', '+9.8%'),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(flex: 6, child: _pipeline()),
                          const SizedBox(width: 6),
                          Expanded(flex: 4, child: _activity()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardSidebar() {
    return Container(
      width: 39,
      decoration: const BoxDecoration(
        color: Color(0xFF172033),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          bottomLeft: Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 23,
            height: 23,
            decoration: BoxDecoration(
              color: const Color(0xFF1677E8),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(
              Icons.cloud_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(height: 10),
          _sideIcon(Icons.dashboard_outlined),
          _sideIcon(Icons.people_outline),
          _sideIcon(Icons.folder_outlined),
          _sideIcon(Icons.analytics_outlined),
          _sideIcon(Icons.settings_outlined),
        ],
      ),
    );
  }

  Widget _sideIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Icon(icon, color: Colors.white.withOpacity(.52), size: 15),
    );
  }

  Widget _metric(String title, String value, String change) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE7ECF2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 6),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontSize: 11.5,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              change,
              style: const TextStyle(
                color: Color(0xFF20A36A),
                fontSize: 5.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pipeline() {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales Pipeline',
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 7,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: CustomPaint(
              painter: _ChartPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activity() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 7,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          _activityItem('AR', 'Aaron Rao', '2m'),
          _activityItem('PN', 'Priya Nair', '5m'),
          _activityItem('VJ', 'Vikram J.', '9m'),
        ],
      ),
    );
  }

  Widget _activityItem(String initials, String name, String time) {
    return SizedBox(
      height: 13,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Color(0xFF172033),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 3.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 5.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 4.5),
          ),
        ],
      ),
    );
  }

  Widget _dashboardPill() {
    return Container(
      width: 14,
      height: 5,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDF3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 465),
              child: Column(
                children: [
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

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 30, 32, 27),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: const Color(0xFFE8EDF3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(.065),
            blurRadius: 42,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLoginBrand(),
            const SizedBox(height: 25),
            const Center(
              child: Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Color(0xFF101828),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.8,
                ),
              ),
            ),
            const SizedBox(height: 7),
            const Center(
              child: Text(
                'Sign in to access your enterprise workspace',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF98A2B3), fontSize: 12),
              ),
            ),
            const SizedBox(height: 28),
            _label('Email address'),
            const SizedBox(height: 8),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration(
                'Enter your email address',
                Icons.email_outlined,
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
            const SizedBox(height: 19),
            Row(
              children: [
                const Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFF344054),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF1677E8),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _login(),
              decoration: _inputDecoration(
                'Enter your password',
                Icons.lock_outline_rounded,
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
                    color: const Color(0xFF98A2B3),
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
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(color: Color(0xFF98A2B3)),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Remember me',
                  style: TextStyle(color: Color(0xFF667085), fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 19),
            _divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _socialButton(
                    Icons.g_mobiledata_rounded,
                    'Google',
                    _googleLogin,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _socialButton(
                    Icons.phone_android_outlined,
                    'Mobile',
                    _mobileLogin,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            _securityBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginBrand() {
    return Center(
      child: AnimatedBuilder(
        animation: pulseController,
        builder: (context, child) {
          final double scale = 1 + pulseController.value * .04;

          return Transform.scale(scale: scale, child: child);
        },
        child: Column(
          children: [
            Container(
              width: 51,
              height: 51,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2585F5), Color(0xFF0D63D8)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1677E8).withOpacity(.22),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.cloud_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'ONE CLOUD',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'ENTERPRISE PLATFORM',
              style: TextStyle(
                color: Color(0xFF1677E8),
                fontSize: 7.5,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
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
        color: Color(0xFF344054),
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF98A2B3), fontSize: 12.5),
      prefixIcon: Icon(icon, color: Color(0xFF98A2B3), size: 19),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFFCFDFE),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE4E7EC)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE4E7EC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF1677E8), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD92D20)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD92D20), width: 1.5),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF146EF5),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF8DB7F4),
          elevation: 3,
          shadowColor: const Color(0xFF146EF5).withOpacity(.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: Colors.white,
                  ),
                )
              : const Row(
                  key: ValueKey('login'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 17),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE4E7EC))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE4E7EC))),
      ],
    );
  }

  Widget _socialButton(IconData icon, String title, VoidCallback onTap) {
    return SizedBox(
      height: 43,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF344054),
          side: const BorderSide(color: Color(0xFFDDE2E8)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _securityBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Row(
        children: [
          Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FF),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Color(0xFF1677E8),
              size: 17,
            ),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enterprise Security',
                  style: TextStyle(
                    color: Color(0xFF344054),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Protected with two-step authentication.',
                  style: TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 9,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_rounded,
            color: Color(0xFF22A06B),
            size: 17,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 6,
      children: const [
        Text(
          '© 2026 ONE CLOUD ENTERPRISE PLATFORM',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF98A2B3),
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Privacy Policy',
          style: TextStyle(color: Color(0xFF98A2B3), fontSize: 8.5),
        ),
        Text(
          'Terms of Service',
          style: TextStyle(color: Color(0xFF98A2B3), fontSize: 8.5),
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return Container(
      color: const Color(0xFFF7F9FC),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              _mobileHeader(),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _mobileHero(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 18, 15, 20),
                child: FadeTransition(
                  opacity: rightFade,
                  child: SlideTransition(
                    position: rightSlide,
                    child: _buildLoginCard(),
                  ),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobileHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2585F5), Color(0xFF0D63D8)],
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.cloud_rounded,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ONE CLOUD',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'ENTERPRISE PLATFORM',
                style: TextStyle(
                  color: Color(0xFF1677E8),
                  fontSize: 7,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEAF4FF), Color(0xFFDCEBFC)],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Smart ',
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: 'Cloud.',
                  style: TextStyle(
                    color: Color(0xFF1677E8),
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Stronger Business.\nBetter Growth.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 27,
              fontWeight: FontWeight.w900,
              height: 1.04,
            ),
          ),
          const SizedBox(height: 11),
          const Text(
            'Your complete enterprise cloud platform '
            'for modern business operations.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 7,
            runSpacing: 7,
            children: [
              _badge(Icons.shield_outlined, 'Secure'),
              _badge(Icons.bolt_rounded, 'Fast'),
              _badge(Icons.cloud_done_outlined, 'Cloud'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _movingCloud({
    required double size,
    required double speed,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return AnimatedBuilder(
      animation: cloudController,
      builder: (context, child) {
        final double movement =
            math.sin(cloudController.value * math.pi * 2 * speed) * 12;

        return Positioned(
          top: top,
          bottom: bottom,
          left: left == null ? null : left + movement,
          right: right == null ? null : right - movement,
          child: Opacity(opacity: .32, child: child),
        );
      },
      child: Icon(Icons.cloud_rounded, size: size, color: Colors.white),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF7FAED9).withOpacity(.08)
      ..strokeWidth = 1;

    const double gap = 35;

    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = const Color(0xFFE8EDF3)
      ..strokeWidth = 1;

    final Paint line = Paint()
      ..color = const Color(0xFF1677E8)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint dots = Paint()..color = const Color(0xFF1677E8);

    for (int i = 1; i <= 3; i++) {
      final double y = size.height * i / 4;

      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    const List<double> values = [.78, .65, .70, .49, .56, .34, .40, .20];

    final Path path = Path();

    for (int i = 0; i < values.length; i++) {
      final double x = size.width * i / (values.length - 1);

      final double y = size.height * values[i];

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, line);

    for (int i = 0; i < values.length; i++) {
      final double x = size.width * i / (values.length - 1);

      final double y = size.height * values[i];

      canvas.drawCircle(Offset(x, y), 2.2, dots);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
