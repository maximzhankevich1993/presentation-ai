import 'dart:ui';

class Slide {
  String title;
  String? subtitle;
  List<String> content;
  String? imageUrl;
  String? imageKeywords;
  bool useCustomImage;
  Color backgroundColor;

  Slide({
    required this.title,
    this.subtitle,
    this.content = const [],
    this.imageUrl,
    this.imageKeywords,
    this.useCustomImage = false,
    this.backgroundColor = const Color(0xFFFFFFFF),
  });

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'content': content,
    'imageUrl': imageUrl,
    'imageKeywords': imageKeywords,
    'useCustomImage': useCustomImage,
    'backgroundColor': backgroundColor.value,
  };

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
    title: json['title'] ?? '',
    subtitle: json['subtitle'],
    content: List<String>.from(json['content'] ?? []),
    imageUrl: json['imageUrl'],
    imageKeywords: json['imageKeywords'],
    useCustomImage: json['useCustomImage'] ?? false,
    backgroundColor: Color(json['backgroundColor'] ?? 0xFFFFFFFF),
  );
}