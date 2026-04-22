import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String topic;

  const LoadingScreen({super.key, required this.topic});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int _step = 0;
  late Timer _timer;
  bool _isGenerating = true;
  
  final List<String> _messages = [
    "🤔 Анализирую тему...",
    "📚 Собираю структуру...",
    "💡 Придумываю слайды...",
    "✍️ Пишу текст...",
    "🖼 Подбираю иллюстрации...",
    "✨ Финальные штрихи...",
  ];

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _simulateGeneration();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_step < _messages.length - 1 && _isGenerating) {
        setState(() => _step++);
      }
    });
  }

  Future<void> _simulateGeneration() async {
    // Имитация генерации (потом заменим на реальный API)
    await Future.delayed(const Duration(seconds: 6));
    
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.useGeneration();
    
    _timer.cancel();
    setState(() => _isGenerating = false);
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
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
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                'assets/animations/loading.json',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.auto_awesome,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey<int>(_step),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  _messages[_step],
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF1E1E2A),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: LinearProgressIndicator(
                value: _isGenerating ? (_step + 1) / _messages.length : null,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}