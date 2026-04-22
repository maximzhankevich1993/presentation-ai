import 'package:hive/hive.dart';

part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  bool isPremium;
  
  @HiveField(1)
  int freeGenerationsLeft;
  
  @HiveField(2)
  int totalGenerationsMade;
  
  @HiveField(3)
  int surpriseMeUsesLeft;
  
  @HiveField(4)
  DateTime? premiumExpiryDate;
  
  @HiveField(5)
  String? email;
  
  @HiveField(6)
  String? name;
  
  @HiveField(7)
  bool newsletterSubscription;

  UserData({
    this.isPremium = false,
    this.freeGenerationsLeft = 5,
    this.totalGenerationsMade = 0,
    this.surpriseMeUsesLeft = 3,
    this.premiumExpiryDate,
    this.email,
    this.name,
    this.newsletterSubscription = false,
  });

  bool get canGenerate {
    if (isPremium) return true;
    return freeGenerationsLeft > 0;
  }

  int get maxSlidesPerPresentation => isPremium ? 50 : 10;

  bool get canUseSurpriseMe {
    if (isPremium) return true;
    return surpriseMeUsesLeft > 0;
  }

  void useFreeGeneration() {
    if (!isPremium && freeGenerationsLeft > 0) {
      freeGenerationsLeft--;
    }
    totalGenerationsMade++;
  }

  void useSurpriseMe() {
    if (!isPremium && surpriseMeUsesLeft > 0) {
      surpriseMeUsesLeft--;
    }
  }

  Map<String, dynamic> toJson() => {
    'isPremium': isPremium,
    'freeGenerationsLeft': freeGenerationsLeft,
    'totalGenerationsMade': totalGenerationsMade,
    'surpriseMeUsesLeft': surpriseMeUsesLeft,
    'premiumExpiryDate': premiumExpiryDate?.toIso8601String(),
    'email': email,
    'name': name,
    'newsletterSubscription': newsletterSubscription,
  };

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    isPremium: json['isPremium'] ?? false,
    freeGenerationsLeft: json['freeGenerationsLeft'] ?? 5,
    totalGenerationsMade: json['totalGenerationsMade'] ?? 0,
    surpriseMeUsesLeft: json['surpriseMeUsesLeft'] ?? 3,
    premiumExpiryDate: json['premiumExpiryDate'] != null 
        ? DateTime.parse(json['premiumExpiryDate']) 
        : null,
    email: json['email'],
    name: json['name'],
    newsletterSubscription: json['newsletterSubscription'] ?? false,
  );
}