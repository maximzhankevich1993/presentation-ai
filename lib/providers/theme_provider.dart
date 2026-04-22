import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType { system, light, dark }
enum InterfaceTheme { default_, cyberpunk, sunset, forest, mint, cherry, cosmic, sand, graphite }

class ThemeProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  ThemeModeType _themeMode = ThemeModeType.system;
  InterfaceTheme _interfaceTheme = InterfaceTheme.default_;
  
  // Настройки фона по умолчанию
  String _defaultBackgroundId = 'white';
  String _defaultGradientId = 'simple';
  String _defaultTextureId = 'kraft';
  String _defaultFontPair = 'modern_tech';
  
  // Размеры шрифтов
  double _titleFontSize = 36;
  double _subtitleFontSize = 24;
  double _bodyFontSize = 18;
  
  // Цвета текста
  Color _titleColor = Colors.black;
  Color _bodyColor = Colors.black87;

  // Геттеры
  ThemeMode get themeMode {
    switch (_themeMode) {
      case ThemeModeType.light:
        return ThemeMode.light;
      case ThemeModeType.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
  
  ThemeModeType get themeModeType => _themeMode;
  InterfaceTheme get interfaceTheme => _interfaceTheme;
  String get defaultBackgroundId => _defaultBackgroundId;
  String get defaultGradientId => _defaultGradientId;
  String get defaultTextureId => _defaultTextureId;
  String get defaultFontPair => _defaultFontPair;
  double get titleFontSize => _titleFontSize;
  double get subtitleFontSize => _subtitleFontSize;
  double get bodyFontSize => _bodyFontSize;
  Color get titleColor => _titleColor;
  Color get bodyColor => _bodyColor;

  ThemeProvider() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    
    final savedMode = _prefs.getString('themeMode') ?? 'system';
    _themeMode = ThemeModeType.values.firstWhere(
      (e) => e.name == savedMode,
      orElse: () => ThemeModeType.system,
    );
    
    final savedTheme = _prefs.getString('interfaceTheme') ?? 'default_';
    _interfaceTheme = InterfaceTheme.values.firstWhere(
      (e) => e.name == savedTheme,
      orElse: () => InterfaceTheme.default_,
    );
    
    _defaultBackgroundId = _prefs.getString('defaultBackgroundId') ?? 'white';
    _defaultGradientId = _prefs.getString('defaultGradientId') ?? 'simple';
    _defaultTextureId = _prefs.getString('defaultTextureId') ?? 'kraft';
    _defaultFontPair = _prefs.getString('defaultFontPair') ?? 'modern_tech';
    
    _titleFontSize = _prefs.getDouble('titleFontSize') ?? 36;
    _subtitleFontSize = _prefs.getDouble('subtitleFontSize') ?? 24;
    _bodyFontSize = _prefs.getDouble('bodyFontSize') ?? 18;
    
    _titleColor = Color(_prefs.getInt('titleColor') ?? Colors.black.value);
    _bodyColor = Color(_prefs.getInt('bodyColor') ?? Colors.black87.value);
    
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeModeType mode) async {
    _themeMode = mode;
    await _prefs.setString('themeMode', mode.name);
    notifyListeners();
  }

  Future<void> setInterfaceTheme(InterfaceTheme theme) async {
    _interfaceTheme = theme;
    await _prefs.setString('interfaceTheme', theme.name);
    notifyListeners();
  }

  Future<void> setDefaultBackground(String id) async {
    _defaultBackgroundId = id;
    await _prefs.setString('defaultBackgroundId', id);
    notifyListeners();
  }

  Future<void> setDefaultGradient(String id) async {
    _defaultGradientId = id;
    await _prefs.setString('defaultGradientId', id);
    notifyListeners();
  }

  Future<void> setDefaultTexture(String id) async {
    _defaultTextureId = id;
    await _prefs.setString('defaultTextureId', id);
    notifyListeners();
  }

  Future<void> setDefaultFontPair(String id) async {
    _defaultFontPair = id;
    await _prefs.setString('defaultFontPair', id);
    notifyListeners();
  }

  Future<void> setTitleFontSize(double size) async {
    _titleFontSize = size;
    await _prefs.setDouble('titleFontSize', size);
    notifyListeners();
  }

  Future<void> setSubtitleFontSize(double size) async {
    _subtitleFontSize = size;
    await _prefs.setDouble('subtitleFontSize', size);
    notifyListeners();
  }

  Future<void> setBodyFontSize(double size) async {
    _bodyFontSize = size;
    await _prefs.setDouble('bodyFontSize', size);
    notifyListeners();
  }

  Future<void> setTitleColor(Color color) async {
    _titleColor = color;
    await _prefs.setInt('titleColor', color.value);
    notifyListeners();
  }

  Future<void> setBodyColor(Color color) async {
    _bodyColor = color;
    await _prefs.setInt('bodyColor', color.value);
    notifyListeners();
  }

  Future<void> init() async {
    await _init();
  }
}