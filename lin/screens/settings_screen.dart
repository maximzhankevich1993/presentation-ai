import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import 'premium_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Тема
          const Text(
            'Оформление',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildThemeOption(
                    title: 'Системная',
                    subtitle: 'Как в настройках телефона',
                    icon: Icons.brightness_4,
                    isSelected: themeProvider.themeModeType == ThemeModeType.system,
                    onTap: () => themeProvider.setThemeMode(ThemeModeType.system),
                  ),
                  const Divider(),
                  _buildThemeOption(
                    title: 'Светлая',
                    subtitle: 'Всегда светлая тема',
                    icon: Icons.light_mode,
                    isSelected: themeProvider.themeModeType == ThemeModeType.light,
                    onTap: () => themeProvider.setThemeMode(ThemeModeType.light),
                  ),
                  const Divider(),
                  _buildThemeOption(
                    title: 'Тёмная',
                    subtitle: 'Всегда тёмная тема',
                    icon: Icons.dark_mode,
                    isSelected: themeProvider.themeModeType == ThemeModeType.dark,
                    onTap: () => themeProvider.setThemeMode(ThemeModeType.dark),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Premium
          if (!userProvider.isPremium)
            Card(
              child: ListTile(
                leading: Icon(Icons.crown, color: Colors.amber[700]),
                title: const Text('Premium'),
                subtitle: const Text('Разблокируй все возможности'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PremiumScreen()),
                  );
                },
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Информация
          const Text(
            'Информация',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Версия приложения'),
                  subtitle: const Text('1.0.0'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.star_outline),
                  title: const Text('Оценить приложение'),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Поделиться с друзьями'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Документы
          const Text(
            'Документы',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('Условия использования'),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Политика конфиденциальности'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Поддержка
          const Text(
            'Поддержка',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Помощь'),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: const Text('Связаться с нами'),
                  subtitle: const Text('support@presentation-ai.com'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFF4F46E5)) : null,
      onTap: onTap,
    );
  }
}