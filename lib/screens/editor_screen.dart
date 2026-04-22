import 'package:flutter/material.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  int _currentSlideIndex = 0;
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Слайд 1',
      'content': ['Пункт 1', 'Пункт 2', 'Пункт 3'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentSlideIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактор'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share),
            tooltip: 'Экспорт',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Предпросмотр',
          ),
        ],
      ),
      body: Row(
        children: [
          // Боковая панель со слайдами
          Container(
            width: 200,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Слайды (${_slides.length})',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _slides.add({
                              'title': 'Новый слайд',
                              'content': ['Введите текст'],
                            });
                          });
                        },
                        icon: const Icon(Icons.add_circle, color: Color(0xFF4F46E5), size: 20),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _slides.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == _currentSlideIndex;
                      return GestureDetector(
                        onTap: () => setState(() => _currentSlideIndex = index),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF4F46E5).withOpacity(0.1) : null,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF4F46E5) : Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4F46E5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _slides[index]['title'],
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Основная область
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: TextEditingController(text: slide['title']),
                    onChanged: (value) {
                      setState(() {
                        _slides[_currentSlideIndex]['title'] = value;
                      });
                    },
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: 'Заголовок слайда',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(slide['content'].length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 8, color: Color(0xFF4F46E5)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: slide['content'][index]),
                              onChanged: (value) {
                                setState(() {
                                  _slides[_currentSlideIndex]['content'][index] = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Пункт ${index + 1}',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _slides[_currentSlideIndex]['content'].add('Новый пункт');
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Добавить пункт'),
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