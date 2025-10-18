import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DrippyApp());
}

class DrippyApp extends StatelessWidget {
  const DrippyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drippy',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7C86)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (_) => const SplashScreen(),
        OnboardingScreen.route: (_) => const OnboardingScreen(),
        AuthScreen.route: (_) => const AuthScreen(),
        LoginScreen.route: (_) => const LoginScreen(),
        SignUpScreen.route: (_) => const SignUpScreen(),
        HomeScreen.route: (_) => const HomeScreen(),
        WishlistScreen.route: (_) => const WishlistScreen(),
        ProfileScreen.route: (_) => const ProfileScreen(),
        BrandsScreen.route: (_) => const BrandsScreen(),
      },
      builder: (context, child) => PhoneFrame(child: child!),
    );
  }
}

class PhoneFrame extends StatelessWidget {
  final Widget child;
  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const aspect = 9 / 16;
    final screenAspect = size.width / size.height;

    if (size.width < 600) return child;

    double targetW, targetH;
    if (screenAspect > aspect) {
      targetH = size.height;
      targetW = targetH * aspect;
    } else {
      targetW = size.width;
      targetH = targetW / aspect;
    }
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(width: targetW, height: targetH, child: child),
      ),
    );
  }
}

/* Splash */
class SplashScreen extends StatefulWidget {
  static const route = '/';
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.route);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBE8),
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 200,
          errorBuilder: (_, __, ___) => const FlutterLogo(size: 120),
        ),
      ),
    );
  }
}

/* Onboarding */
class OnboardingScreen extends StatefulWidget {
  static const route = '/onboarding';
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}
class _OnboardingPageData {
  final String imagePath;
  final String title;
  final String subtitle;
  final Alignment imageAlignment;
  const _OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.imageAlignment = Alignment.center,
  });
}
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final _pages = const [
    _OnboardingPageData(
      imagePath: 'assets/onboarding1.png',
      title: 'START YOUR FASHION\nJOURNEY',
      subtitle:
          'Join a community of creativity and inclusivity. Express your unique style and stay updated with the latest fashion trends.',
      imageAlignment: Alignment.centerRight,
    ),
    _OnboardingPageData(
      imagePath: 'assets/onboarding2.png',
      title: 'DISCOVER YOUR PERSONAL\nSTYLE',
      subtitle:
          'Confidently explore personalized styles that reflect Egypt\'s diverse fashion culture, tailored just for you.',
      imageAlignment: Alignment.center,
    ),
    _OnboardingPageData(
      imagePath: 'assets/onboarding3.png',
      title: 'WELCOME TO THE DIGITAL\nFASHION WORLD',
      subtitle:
          'Experience innovative fashion by connecting with Egypt\'s top local brands and exploring our immersive virtual dressing room.',
      imageAlignment: Alignment.centerLeft,
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _finish();
    }
  }
  void _finish() => Navigator.of(context).pushReplacementNamed(AuthScreen.route);

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.viewPaddingOf(context).bottom;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) {
                final p = _pages[i];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        p.imagePath,
                        fit: BoxFit.cover,
                        alignment: p.imageAlignment,
                        errorBuilder: (_, __, ___) =>
                            const ColoredBox(color: Colors.black12),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.06),
                              Colors.black.withOpacity(0.34),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.paddingOf(context).top + 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'DRIPPY',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                                color: Colors.black.withOpacity(0.85),
                              ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 96 + bottomPad,
                      child: _GlassCard(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              p.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              p.subtitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    height: 1.45,
                                    color: Colors.white.withOpacity(0.95),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 44 + bottomPad,
              child: SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: _next,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(_index == _pages.length - 1 ? 'START' : 'NEXT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.30),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}

/* Auth (full background) */
class AuthScreen extends StatelessWidget {
  static const route = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final fit = kIsWeb ? BoxFit.contain : BoxFit.cover;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/auth_bg.png',
              fit: fit,
              alignment: Alignment.center,
              errorBuilder: (_, __, ___) =>
                  const ColoredBox(color: Colors.black12),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.30)),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _GlassCard(
                    child: Text(
                      'Sign up or log in to your account to access exclusive content',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginScreen.route),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text('LOG IN'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, SignUpScreen.route),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black, width: 1.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text('SIGN UP',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, HomeScreen.route),
                    child: const Text(
                      'Continue as a Guest',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* Login */
class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  bool _obscure = true;

  InputDecoration _underlineInput(String label, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 14),
      border: const UnderlineInputBorder(),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.2),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 12 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text('LOGIN', style: TextStyle(letterSpacing: 1)),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'WELCOME BACK',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Sign in with your email address and your password',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: _underlineInput('Email / Phone'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 22),
                    TextFormField(
                      decoration: _underlineInput(
                        'Password',
                        suffix: IconButton(
                          icon: Icon(_obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () =>
                              setState(() => _obscure = !_obscure),
                        ),
                      ),
                      obscureText: _obscure,
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot your password ?'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.route);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Text('LOG IN'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? ",
                      style: Theme.of(context).textTheme.bodyMedium),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, SignUpScreen.route),
                    child: const Text('Create an Account'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(radius: 18, child: Text('G')),
                  SizedBox(width: 24),
                  Icon(Icons.apple, size: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* Sign Up */
class SignUpScreen extends StatefulWidget {
  static const route = '/signup';
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _agree = true;

  InputDecoration _underlineInput(String label, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 14),
      border: const UnderlineInputBorder(),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.2),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 12 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text('SIGNUP', style: TextStyle(letterSpacing: 1)),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'CREATE YOUR ACCOUNT',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Create your account to have access to a personalized experience',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('Already have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, LoginScreen.route),
                    child: const Text('Log in Here'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Form(
                key: _form,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: _underlineInput('First Name'),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            decoration: _underlineInput('Surname'),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: _underlineInput('Email'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: _underlineInput('Mobile Number'),
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: _underlineInput(
                        'Password',
                        suffix: IconButton(
                          icon: Icon(_obscure1
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () =>
                              setState(() => _obscure1 = !_obscure1),
                        ),
                      ),
                      obscureText: _obscure1,
                      validator: (v) =>
                          (v == null || v.length < 6)
                              ? 'Min 6 characters'
                              : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: _underlineInput(
                        'Confirm Password',
                        suffix: IconButton(
                          icon: Icon(_obscure2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () =>
                              setState(() => _obscure2 = !_obscure2),
                        ),
                      ),
                      obscureText: _obscure2,
                      validator: (v) =>
                          (v == null || v.length < 6)
                              ? 'Min 6 characters'
                              : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                  const Expanded(
                    child: Text(
                        'I have read and understand The Terms and The Privacy Policy by clicking of the Sign Up button'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_form.currentState!.validate() && _agree) {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.route);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Text('SIGN UP'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(radius: 18, child: Text('G')),
                  SizedBox(width: 24),
                  Icon(Icons.apple, size: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* HOME + Drawer + Sections */
class HomeScreen extends StatelessWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _DrippyDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Image.asset(
          'assets/homelogo.png', // centered home logo
          height: 28,
          errorBuilder: (_, __, ___) =>
              const Text('DRIPPY', style: TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon:
                const Icon(Icons.favorite_border_outlined, color: Colors.black),
            onPressed: () =>
                Navigator.pushNamed(context, WishlistScreen.route),
          ),
          IconButton(
            icon:
                const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: const _HomeBody(),
    );
  }
}

/* Drawer uses homelogo2.png */
class _DrippyDrawer extends StatelessWidget {
  const _DrippyDrawer();

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
      letterSpacing: 0.5,
    );

    Widget item(
        {required IconData icon,
        required String label,
        required VoidCallback onTap}) {
      return ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(label, style: textStyle),
        onTap: onTap,
        horizontalTitleGap: 8,
        dense: true,
      );
    }

    return Drawer(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Image.asset(
                'assets/homelogo2.png', // updated drawer logo
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Text(
                  'DRIPPY',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 24),
              item(
                icon: Icons.home_outlined,
                label: 'HOME',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, HomeScreen.route);
                },
              ),
              item(
                icon: Icons.favorite_border_outlined,
                label: 'WISHLIST',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, WishlistScreen.route);
                },
              ),
              item(
                icon: Icons.person_outline,
                label: 'PROFILE',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, ProfileScreen.route);
                },
              ),
              item(
                icon: Icons.local_offer_outlined,
                label: 'BRANDS',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, BrandsScreen.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/banner1.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  errorBuilder: (_, __, ___) =>
                      const ColoredBox(color: Colors.black12),
                ),
              ),
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "NEW STYLE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "MADE FOR CHANGE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _sectionHeader("CATEGORIES", onViewAll: () {}),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _categoryItem('assets/category_dress.png', 'Dress'),
                _categoryItem('assets/category_bag.png', 'Bag'),
                _categoryItem('assets/category_shoes.png', 'Shoes'),
                _categoryItem('assets/category_accessories.png', 'Accs.'),
              ],
            ),
          ),

          const SizedBox(height: 20),
          _sectionHeader("NEW ARRIVAL", onViewAll: () {}),
          const SizedBox(height: 8),
          Row(
            children: [
              _productItem('assets/new1.png', 'Angora Cardigan', '600 EGP'),
              const SizedBox(width: 12),
              _productItem('assets/new2.png', 'Brown Sweater', '550 EGP'),
            ],
          ),

          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/new1.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
                errorBuilder: (_, __, ___) =>
                    const ColoredBox(color: Colors.black12)),
          ),
          const SizedBox(height: 24),

          _sectionHeader("WINTER COLLECTION", onViewAll: () {}),
          const SizedBox(height: 8),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70,
            children: [
              _gridProduct('assets/collection1.png', 'Wool Coat', '900 EGP'),
              _gridProduct('assets/collection2.png', 'Long Coat', '950 EGP'),
              _gridProduct('assets/collection3.png', 'Beige Jacket', '800 EGP'),
              _gridProduct('assets/collection4.png', 'White Sweater', '650 EGP'),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _sectionHeader(String title, {VoidCallback? onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child:
              const Text("See All >", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  static Widget _categoryItem(String img, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundImage: AssetImage(img)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  static Widget _productItem(String img, String name, String price) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(img, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const ColoredBox(color: Colors.black12)),
                  ),
                  const Positioned(
                    right: 6,
                    top: 6,
                    child: Icon(Icons.favorite_border_outlined,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(name,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, height: 1.2)),
          Text(price,
              style:
                  const TextStyle(fontSize: 13, color: Colors.grey, height: 1.1)),
        ],
      ),
    );
  }

  static Widget _gridProduct(String img, String name, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1 / 1.1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(img, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: Colors.black12)),
                ),
                const Positioned(
                  right: 6,
                  top: 6,
                  child: Icon(Icons.favorite_border_outlined,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(name,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, height: 1.2)),
        Text(price,
            style:
                const TextStyle(fontSize: 13, color: Colors.grey, height: 1.1)),
      ],
    );
  }
}

/* Drawer target pages */
class WishlistScreen extends StatelessWidget {
  static const route = '/wishlist';
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _DrippyDrawer(),
      appBar: AppBar(
        title: const Text('Wishlist'),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      body: const Center(child: Text('Wishlist placeholder')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  static const route = '/profile';
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _DrippyDrawer(),
      appBar: AppBar(
        title: const Text('Profile'),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      body: const Center(child: Text('Profile placeholder')),
    );
  }
}

class BrandsScreen extends StatelessWidget {
  static const route = '/brands';
  const BrandsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _DrippyDrawer(),
      appBar: AppBar(
        title: const Text('Brands'),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      body: const Center(child: Text('Brands placeholder')),
    );
  }
}



