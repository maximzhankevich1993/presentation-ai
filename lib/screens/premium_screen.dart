import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.crown, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Разблокируй всё',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Создавай профессиональные презентации\nбез ограничений',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Таблица сравнения
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildCompareRow('Генерации презентаций', '5', '∞'),
                  _buildCompareRow('Слайдов в презентации', '10', '50'),
                  _buildCompareRow('Автоматические картинки', '10', '50'),
                  _buildCompareRow('Загрузка своего фона', '❌', '✅'),
                  _buildCompareRow('Цветовые схемы', '2', '8+'),
                  _buildCompareRow('Шрифтовые пары', '2', '6+'),
                  _buildCompareRow('Анимированные переходы', '2', '10+'),
                  _buildCompareRow('ИИ-улучшение текста', '❌', '✅'),
                  _buildCompareRow('Экспорт в PDF', '❌', '✅'),
                  _buildCompareRow('Водяной знак', 'Есть', 'Нет'),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Планы
            _buildPlanCard(
              context,
              title: 'Месяц',
              price: '299 ₽',
              period: 'мес',
              onTap: () => _purchase('monthly'),
            ),
            const SizedBox(height: 12),
            _buildPlanCard(
              context,
              title: 'Полгода',
              price: '199 ₽',
              period: 'мес',
              total: '1194 ₽ за 6 мес',
              discount: '33%',
              isPopular: true,
              onTap: () => _purchase('halfyear'),
            ),
            const SizedBox(height: 12),
            _buildPlanCard(
              context,
              title: 'Год',
              price: '149 ₽',
              period: 'мес',
              total: '1788 ₽ за год',
              discount: '50%',
              onTap: () => _purchase('yearly'),
            ),
            
            const SizedBox(height: 24),
            
            Center(
              child: TextButton(
                onPressed: () => _restorePurchases(context),
                child: const Text('Восстановить покупки'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompareRow(String feature, String free, String premium) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(feature, style: const TextStyle(fontSize: 14))),
          Expanded(
            child: Text(free, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ),
          Expanded(
            child: Text(premium, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String price,
    required String period,
    String? total,
    String? discount,
    bool isPopular = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isPopular ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPopular ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.2),
            width: isPopular ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            if (isPopular)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('ПОПУЛЯРНЫЙ', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  if (total != null)
                    Text(total, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(' /$period', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
                if (discount != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Экономия $discount', style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _purchase(String plan) {
    // Заглушка для покупки
  }

  void _restorePurchases(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Покупки восстановлены')),
    );
  }
}