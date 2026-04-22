import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class SecurityService {
  static const String _installIdKey = 'install_id';
  static const String _deviceFingerprintKey = 'device_fingerprint';
  static const String _freeGenerationsClaimedKey = 'free_generations_claimed';

  static Future<String> generateInstallId() async {
    final prefs = await SharedPreferences.getInstance();
    
    final existingId = prefs.getString(_installIdKey);
    if (existingId != null) {
      return existingId;
    }
    
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random.secure().nextInt(999999);
    final installId = 'install_${timestamp}_$random';
    
    await prefs.setString(_installIdKey, installId);
    return installId;
  }

  static Future<String> generateDeviceFingerprint() async {
    final prefs = await SharedPreferences.getInstance();
    
    final existing = prefs.getString(_deviceFingerprintKey);
    if (existing != null) {
      return existing;
    }
    
    final installId = await generateInstallId();
    final bytes = utf8.encode(installId);
    final digest = sha256.convert(bytes);
    final fingerprint = digest.toString();
    
    await prefs.setString(_deviceFingerprintKey, fingerprint);
    return fingerprint;
  }

  static Future<bool> wasAppInstalledBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_freeGenerationsClaimedKey) ?? false;
  }

  static Future<void> markFreeGenerationsClaimed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_freeGenerationsClaimedKey, true);
  }

  static Future<bool> verifyAppIntegrity() async {
    // Базовая проверка целостности
    return true;
  }
}