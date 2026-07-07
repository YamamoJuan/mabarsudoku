class FirebaseConfig {
  static const String projectId = 'PLACEHOLDER_PROJECT_ID';
  static const String apiKey = 'PLACEHOLDER_API_KEY';
  static const String appId = 'PLACEHOLDER_APP_ID';
  static const String messagingSenderId = 'PLACEHOLDER_MESSAGING_SENDER_ID';

  static const Map<String, String> androidConfig = {
    'package': 'com.mabarsudoku.app',
  };

  static const Map<String, String> iosConfig = {
    'bundleId': 'com.mabarsudoku.app',
  };

  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
}
