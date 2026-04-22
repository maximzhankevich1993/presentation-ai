class AppConstants {
  static const String appName = 'Презентатор ИИ';
  static const String appVersion = '1.0.0';
  
  static const int freeGenerations = 5;
  static const int maxFreeSlides = 10;
  static const int maxPremiumSlides = 50;
  
  static const int freeSurpriseMeUses = 3;
  
  static const List<String> supportedLanguages = [
    'ru', 'en', 'es', 'pt', 'de', 'fr', 'zh', 'ja', 'ko'
  ];
  
  static const String supportEmail = 'support@presentation-ai.com';
  static const String privacyPolicyUrl = 'https://presentation-ai.com/privacy';
  static const String termsOfServiceUrl = 'https://presentation-ai.com/terms';
}

class ApiConstants {
  static const String deepseekBaseUrl = 'https://api.deepseek.com/v1';
  static const String unsplashBaseUrl = 'https://api.unsplash.com';
  static const String pexelsBaseUrl = 'https://api.pexels.com/v1';
}

class StorageKeys {
  static const String themeMode = 'theme_mode';
  static const String interfaceTheme = 'interface_theme';
  static const String userData = 'user_data';
  static const String presentations = 'presentations';
  static const String settings = 'settings';
}