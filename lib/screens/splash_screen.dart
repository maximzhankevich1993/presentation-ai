import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  final List<String> _doodlePhrases = [
    "🎨 Рисую идеи...",
    "✏️ Набрасываю концепты...",
    "🖍️ Добавляю цвета...",
    "✨ Вдыхаю магию...",
    "🚀 Запускаем!",
  ];
  
  int _currentPhrase = 0;
  Timer? _phraseTimer;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.elasticOut),
      ),
    );
    
    _controller.forward();
    
    _phraseTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (_currentPhrase < _doodlePhrases.length - 1) {
        setState(() => _currentPhrase++);
      }
    });
    
    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    await Provider.of<ThemeProvider>(context, listen: false).init();
    await Provider.of<UserProvider>(context, listen: false).init();
    
    Timer(const Duration(milliseconds: 2800), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _phraseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E2A) : const Color(0xFFFAFAFA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF4F46E5).withOpacity(0.1),
                        border: Border.all(
                          color: const Color(0xFF4F46E5),
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 60,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 40.h),
            Text(
              'Презентатор ИИ',
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4F46E5),
              ),
            ),
            SizedBox(height: 20.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey(_currentPhrase),
                child: Text(
                  _doodlePhrases[_currentPhrase],
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isDark ? Colors.white70 : Colors.grey[700],
                  ),
                ),
              ),
            ),
            SizedBox(height: 60.h),
            SizedBox(
              width: 200.w,
              child: LinearProgressIndicator(
                value: _controller.value,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}