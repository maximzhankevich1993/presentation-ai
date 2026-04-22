import 'package:flutter/material.dart';

class AppColors {
  // Основные
  static const Color primary = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF10B981);
  static const Color accent = Color(0xFFF59E0B);
  
  // Светлая тема
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E1E2A);
  static const Color lightSubtext = Color(0xFF6B6B7B);
  
  // Тёмная тема
  static const Color darkBackground = Color(0xFF1E1E2A);
  static const Color darkSurface = Color(0xFF2A2A3A);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkSubtext = Color(0xFFA0A0B0);
  
  // Цветовые темы интерфейса
  static const List<ColorTheme> interfaceThemes = [
    ColorTheme(name: 'Киберпанк', primary: Color(0xFF00FFCC), background: Color(0xFF0B0C10)),
    ColorTheme(name: 'Закат', primary: Color(0xFFFF7B54), background: Color(0xFF2D1B4E)),
    ColorTheme(name: 'Северный лес', primary: Color(0xFFC5A059), background: Color(0xFF1E3E3E)),
    ColorTheme(name: 'Мятный', primary: Color(0xFF2C5F4F), background: Color(0xFFF4F8F4)),
    ColorTheme(name: 'Вишнёвый', primary: Color(0xFFE84A5F), background: Color(0xFF3E1E1E)),
    ColorTheme(name: 'Космический', primary: Color(0xFF9038FF), background: Color(0xFF1A1A2E)),
    ColorTheme(name: 'Песчаный', primary: Color(0xFF4A8B9C), background: Color(0xFFF4E8D4)),
    ColorTheme(name: 'Графитовый', primary: Color(0xFFE0E0E0), background: Color(0xFF2A2A2A)),
  ];
}

class ColorTheme {
  final String name;
  final Color primary;
  final Color background;
  
  const ColorTheme({
    required this.name,
    required this.primary,
    required this.background,
  });
}