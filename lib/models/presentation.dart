import 'slide.dart';

class Presentation {
  final String id;
  final String title;
  final List<Slide> slides;
  final DateTime createdAt;
  String? fontPair;
  String? themeId;
  String transitionType;

  Presentation({
    required this.id,
    required this.title,
    required this.slides,
    required this.createdAt,
    this.fontPair,
    this.themeId,
    this.transitionType = 'fade',
  });

  int get slideCount => slides.length;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slides': slides.map((s) => s.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'fontPair': fontPair,
    'themeId': themeId,
    'transitionType': transitionType,
  };

  factory Presentation.fromJson(Map<String, dynamic> json) => Presentation(
    id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
    title: json['title'] ?? 'Без названия',
    slides: (json['slides'] as List? ?? [])
        .map((s) => Slide.fromJson(s))
        .toList(),
    createdAt: json['createdAt'] != null 
        ? DateTime.parse(json['createdAt']) 
        : DateTime.now(),
    fontPair: json['fontPair'],
    themeId: json['themeId'],
    transitionType: json['transitionType'] ?? 'fade',
  );

  factory Presentation.fromDeepSeekJson(Map<String, dynamic> json) {
    final slides = (json['slides'] as List).map((slideJson) {
      return Slide.fromJson(slideJson);
    }).toList();
    
    return Presentation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'] ?? 'Без названия',
      slides: slides,
      createdAt: DateTime.now(),
    );
  }
}