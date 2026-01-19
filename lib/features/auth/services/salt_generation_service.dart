import 'dart:math';
import 'dart:convert';

class SaltGenerationService {
  String generateSalt() {
    final rand = Random.secure();
    final saltBytes = List<int>.generate(16, (_) => rand.nextInt(256));
    return base64Encode(saltBytes);
  }
}
