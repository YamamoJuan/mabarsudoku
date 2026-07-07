import 'package:firebase_core/firebase_core.dart';
import '../../core/firebase/firebase_config.dart';

class FirebaseService {
  static Future<void> initialize() async {
    if (Firebase.apps.isNotEmpty) return;
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: FirebaseConfig.apiKey,
        appId: FirebaseConfig.appId,
        projectId: FirebaseConfig.projectId,
        messagingSenderId: FirebaseConfig.messagingSenderId,
      ),
    );
  }
}
